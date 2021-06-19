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
      case 1: return SectionFactory.productDetailInfoSection
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
  
  let orderButton: UIButton = .init(frame: .zero)
  let dividerView: UIView = .init(frame: .zero)
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // 코드 수정해야함.
    viewModel?.productDeatilIndex.send(4)
  }
  
  func bindViewModel() {
    viewModel?.product
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        print($0)
        // MARK: - 업데이트 해줘야함
      }
      .store(in: &cancellables)
    
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
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
    
//    title = "상세 보기"
    
//    if let orderCompletedProduct = viewModel?.orderCompletedProduct {
//      orderCompletedStackView.updateView(with: orderCompletedProduct)
//    }
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
    case 0: return 3
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
      
      return cell
      
    case 1:
      let cell: ProductDetailInfoViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
      let glanceableInfo =  GlanceableInfo(color: "아이보리", size: "S", material: "울 100%")
      let fullInfo = FullInfo(brand: "무신사 스토어", washing: "첫 세탁은 드라이 클리닝을 추천합니다.\n서늘한 곳에 보관하고 직사광선을 피해주세요", details: "첫 세탁은 드라이 클리닝을 추천합니다.\n서늘한 곳에 보관하고 직사광선을 피해주세요")
      
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
  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    viewModel?.detailProductEvent.send(1)
//  }
}
