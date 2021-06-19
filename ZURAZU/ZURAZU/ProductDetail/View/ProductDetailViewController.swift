//
//  ProductDetailViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/26.
//

import UIKit
import Combine

final class ProductDetailViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: ProductDetailViewModelType?
  
  private lazy var backButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  private lazy var collectionView: UICollectionView = {
    typealias SectionFactory = CollectionViewLayoutSectionFactory
    
    let layout: UICollectionViewCompositionalLayout = .init(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
      switch sectionIndex {
      case 0: return SectionFactory.fullScreenHorizontalImageSection
      case 1: return SectionFactory.productDetailInfoSection()
      case 2: return SectionFactory.horizontalProductSection(headerItem: SectionFactory.headerItem)
      default: return nil
      }
    })
    
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .monoQuinary
    
    collectionView.register(ProductDetailImageViewCell.self)
    collectionView.register(ProductGradeFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ProductGradeFooterView")
    collectionView.register(ProductDetailInfoViewCell.self)
    collectionView.register(ProductThumbnailViewCell.self)
    collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
    
    return collectionView
  }()
  
  private let orderButton: UIButton = .init(frame: .zero)
  private let dividerView: UIView = .init(frame: .zero)
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBarController?.tabBar.isHidden = true
    viewModel?.requestProductDetailData.send()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    tabBarController?.tabBar.isHidden = false
  }
  
  func bindViewModel() {
    viewModel?.product
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink { [weak self] _ in
        self?.collectionView.reloadData()
      }
      .store(in: &cancellables)
    
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
    
    orderButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.orderEvent.send()
      }
      .store(in: &cancellables)
  }
}

private extension ProductDetailViewController {
  
  func setupView() {
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
    
    dividerView.backgroundColor = .monoQuinary
    
    orderButton.backgroundColor = .bluePrimary
    orderButton.setTitle("구매하기", for: .normal)
    orderButton.titleLabel?.font = .secondaryBold
    orderButton.setTitleColor(.white, for: .normal)
  }
  
  func setupConstraint() {
    [collectionView, orderButton, dividerView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      dividerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
      dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      dividerView.heightAnchor.constraint(equalToConstant: 2),
      
      orderButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 8),
      orderButton.heightAnchor.constraint(equalToConstant: 48),
      orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
    ])
  }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0: return viewModel?.images.value.count ?? 0
    case 1: return 1
    case 2: return 10
    default: return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell: ProductDetailImageViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
      cell.update(image: #imageLiteral(resourceName: "imgKakaofriendsFailure"))
      cell.backgroundColor = .white
      
      let imageService: ImageService = .init()
      
      guard let imageURL = viewModel?.images.value[indexPath.item] else { return cell }
      
      imageService.loadImage(by: imageURL.url) { image in
        cell.update(image: image ?? #imageLiteral(resourceName: "imgKakaofriendsFailure"))
      }
      
      return cell
      
    case 1:
      let cell: ProductDetailInfoViewCell = collectionView.dequeueReusableCell(forIndexPath: .init())
      
      guard let product = viewModel?.product.value else { return cell }
      
      let glanceableInfo: GlanceableInfo = .init(color: product.colorChip.colorText, size: product.clothingSize, material: product.material)
      let fullInfo: FullInfo = .init(brand: product.brand, washing: product.laundryComment, details: product.infoComment)
      
      cell.update(glanceableInfo: glanceableInfo, fullInfo: fullInfo)
      cell.backgroundColor = .white
      
      return cell
      
    default:
      let cell: ProductThumbnailViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
      cell.update(image: #imageLiteral(resourceName: "imgKakaofriendsFailure"), info: .init(brandName: "brand", name: "name", price: "10000"), size: .medium)
      cell.backgroundColor = .white
      
      return cell
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    3
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionFooter,
       let footerView: ProductGradeFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProductGradeFooterView", for: indexPath) as? ProductGradeFooterView {
      
      footerView.backgroundColor = .white
      footerView.inspectionStandardButton.tapPublisher.sink { [weak self] in
        self?.viewModel?.inspectionStandardEvent.send()
      }
      .store(in: &cancellables)
      
      guard let product = viewModel?.product.value else { return footerView }
      
      footerView.updateView(with: product)
      
      return footerView
    }
    
    if kind == UICollectionView.elementKindSectionHeader,
       let headerView: SectionHeaderView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "SectionHeaderView",
        for: indexPath) as? SectionHeaderView {
      headerView.update(with: SectionTitle.zurazuPick)
      headerView.backgroundColor = .white
      
      return headerView
    }
    
    return UICollectionReusableView()
  }
}
