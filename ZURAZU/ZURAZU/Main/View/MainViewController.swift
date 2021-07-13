//
//  MainViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/07.
//

import UIKit
import Combine

final class MainViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: MainViewModelType?
  
  private lazy var collectionView: UICollectionView = {
    typealias SectionFactory = CollectionViewLayoutSectionFactory
    
    let layout: UICollectionViewCompositionalLayout = .init(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
      switch sectionIndex {
      case 0: return SectionFactory.horizontalProductSection(headerItem: SectionFactory.headerItem)
      case 1: return SectionFactory.mainProductSection(headerItem: SectionFactory.headerItem)
      default: return nil
      }
    })
    
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .monoQuinary
    
    collectionView.register(ProductThumbnailViewCell.self)
    collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
    
    return collectionView
  }()
  
  lazy var salesApplicationButton: UIButton = {
    let button: UIButton = .init()
    let image: UIImage? = .init(systemName: "plus.app")
    
    button.backgroundColor = .bluePrimary
    button.setImage(image, for: .normal)
    button.setTitle("판매 신청하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.monoQuaternary, for: .highlighted)
    button.titleLabel?.font = .tertiaryBold
    button.imageView?.contentMode = .scaleAspectFill
    button.imageView?.tintColor = .white
    button.contentHorizontalAlignment = .center
    button.semanticContentAttribute = .forceLeftToRight
    button.layer.cornerRadius = 5
    
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
    return button
  }()
  
  private lazy var logoImageView: UIImageView = {
    let imageView: UIImageView = .init(image: .logoText)
    
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupConstraint()
    binding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupNavigationBar()
    viewModel?.requestProductsData.send()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    logoImageView.removeFromSuperview()
  }
}

extension MainViewController {
  
  private func setupConstraint() {
    [collectionView, salesApplicationButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      salesApplicationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      salesApplicationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      salesApplicationButton.widthAnchor.constraint(equalToConstant: 130),
      salesApplicationButton.heightAnchor.constraint(equalToConstant: 35)
    ])
  }
  
  func setupNavigationBar() {
    guard let navigationBar = navigationController?.navigationBar else { return }
    navigationController?.setNavigationBarHidden(false, animated: false)
    
    navigationBar.addSubview(logoImageView)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      logoImageView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16),
      logoImageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
      logoImageView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor, multiplier: 0.3)
    ])
  }
  
  func binding(){
    salesApplicationButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.salesApplicationEvent.send()
      }
      .store(in: &cancellables)
    
    viewModel?.products
      .receive(on: Scheduler.main)
      .sink { [weak self] _ in
        self?.collectionView.reloadData()
      }
      .store(in: &cancellables)
  }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.products.value.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ProductThumbnailViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    let size: ProductThumbnailSize
    
    switch indexPath.section {
    case 0: size = .medium
    case 1: size = .large
    default: size = .small
    }
    
    guard let product = viewModel?.products.value[indexPath.row] else { return cell }
    
    let info: ProductThumbnailInfo = .init(
      brandName: product.brand,
      name: product.name,
      price: product.price.decimalWon()
    )
    
    cell.update(image: #imageLiteral(resourceName: "imgKakaofriendsFailure"), info: info, size: size)
    
    ImageService().loadImage(by: product.image.url) { image in
      cell.update(image: image)
    }

    cell.backgroundColor = .white
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    2
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader,
       let headerView: SectionHeaderView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "SectionHeaderView",
        for: indexPath) as? SectionHeaderView {
      
      switch indexPath.section {
      case 0: headerView.update(with: SectionTitle.zurazuPick)
      case 1: headerView.update(with: SectionTitle.title(with: "NEW"))
      default: headerView.update(with: SectionTitle.zurazuPick)
      }
      
      headerView.backgroundColor = .white
      
      return headerView
    }
    
    return CollectionSeparatorView()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.detailProductEvent.send(indexPath.row)
  }
}
