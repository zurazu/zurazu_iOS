//
//  OrderViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/19.
//

import UIKit
import Combine

final class OrderViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: OrderViewModelType?
  
  private lazy var backButton: UIButton = {
    let button: UIButton = .init(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  private lazy var collectionView: UICollectionView = {
    typealias SectionFactory = CollectionViewLayoutSectionFactory
    
    let layout: UICollectionViewFlowLayout = .init()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 140)
    
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .monoQuinary
    
    collectionView.register(OrdererInfoViewCell.self)
    collectionView.register(OrderProductViewCell.self)
    collectionView.register(OrderPaymentInfoViewCell.self)
    collectionView.register(OrderPriceInfoViewCell.self)
    
    return collectionView
  }()
  
  private let orderButton: UIButton = .init(frame: .zero)
  
  private var cancellables: Set<AnyCancellable> = []
  
  var name: String? {
    didSet {
      orderInfoDidEdit()
      viewModel?.name = name
    }
  }
  
  var phoneNumber: String? {
    didSet {
      orderInfoDidEdit()
      viewModel?.phoneNumber = phoneNumber
    }
  }
  
  var email: String? {
    didSet {
      orderInfoDidEdit()
      viewModel?.email = email
    }
  }
  
  private var ordererInfo: String? {
    didSet {
      guard !(ordererInfo?.isEmpty ?? true) else {
        orderButton.isEnabled = false
        orderButton.backgroundColor = .blueSecondary
        return
      }
      orderButton.isEnabled = true
      orderButton.backgroundColor = .bluePrimary
    }
  }
  
  private func orderInfoDidEdit() {
    guard let name = name, !name.isEmpty,
          let phoneNumber = phoneNumber, !phoneNumber.isEmpty,
          let email = email, !email.isEmpty else {
      ordererInfo = ""
      
      return
    }
    ordererInfo = name + " " + phoneNumber
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBarController?.tabBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    tabBarController?.tabBar.isHidden = false
  }
}

private extension OrderViewController {
  
  func setupView() {
    title = "주문하기"
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
    
    orderButton.setTitle("주문하기", for: .normal)
    orderButton.titleLabel?.font = .secondaryBold
    orderButton.setTitleColor(.white, for: .normal)
    orderButton.isEnabled = false
    orderButton.backgroundColor = .blueSecondary
  }
  
  func setupConstraint() {
    [collectionView, orderButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      orderButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
      orderButton.heightAnchor.constraint(equalToConstant: 48),
      orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
    ])
  }
  
  func binding() {
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
    
    orderButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.ordererInfo = self?.ordererInfo
        self?.viewModel?.orderEvent.send()
      }
      .store(in: &cancellables)
  }
}

extension OrderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.item {
    case 0:
      let cell: OrdererInfoViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
      cell.backgroundColor = .white
      cell.delegate = self
      
      return cell
      
    case 1:
      let cell: OrderProductViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
      let info = ProductThumbnailInfo(brandName: viewModel?.product.brand, name: viewModel?.product.name, price: String(viewModel?.product.price ?? 0))
      let imageService: ImageService = .init()
      
      cell.backgroundColor = .white

      guard let imageURL = viewModel?.imageURL else {
        cell.update(image: #imageLiteral(resourceName: "imgKakaofriendsFailure"), info: info)
        
        return cell
      }
      
      imageService.loadImage(by: imageURL) { image in
        cell.update(image: image ?? #imageLiteral(resourceName: "imgKakaofriendsFailure"), info: info)
      }
      
      return cell
      
    case 2:
      let cell: OrderPaymentInfoViewCell = collectionView.dequeueReusableCell(forIndexPath: .init())
      cell.backgroundColor = .white
      
      return cell
      
    default:
      let cell: OrderPriceInfoViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
      
      cell.setup(price: String(viewModel?.product.price ?? 0))
      cell.backgroundColor = .white
      
      return cell
    }
  }
}

extension OrderViewController: OrdererInfoViewDelegate {
  
}
