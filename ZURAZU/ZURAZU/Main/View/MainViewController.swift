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
  
  private let datas: [ProductThumbnailInfo] = [.init(brandName: "1", name: "hello", price: "10000"),
                                               .init(brandName: "2", name: "hello", price: "10000"),
                                               .init(brandName: "3", name: "hello", price: "10000"),
                                               .init(brandName: "4", name: "hello", price: "10000"),
                                               .init(brandName: "5", name: "hello", price: "10000"),
                                               .init(brandName: "6", name: "hello", price: "10000"),
                                               .init(brandName: "7", name: "hello", price: "10000"),
                                               .init(brandName: "8", name: "hello", price: "10000")]
  
  private lazy var collectionView: UICollectionView = {
    typealias SectionFactory = CollectionViewLayoutSectionFactory
    
    let layout: UICollectionViewCompositionalLayout = .init(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
      switch sectionIndex {
      case 0: return SectionFactory.horizontalProductSection(headerItem: SectionFactory.headerItem,
                                                             footerItem: SectionFactory.footerItem)
      case 1: return SectionFactory.mainProductSection(headerItem: SectionFactory.headerItem,
                                                       footerItem: SectionFactory.footerItem)
      default: return nil
      }
    })
    
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    
    collectionView.register(ProductThumbnailViewCell.self)
    collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
    collectionView.register(CollectionSeparatorView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionSeparatorView")
    
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupConstraint()
  }
  
  func bindViewModel() {
    
  }
  
}

extension MainViewController {
  
  private func setupConstraint() {
    [collectionView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    datas.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ProductThumbnailViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    let size: ProductThumbnailSize
    
    switch indexPath.section {
    case 0: size = .medium
    case 1: size = .large
    default: size = .small
    }
    
    cell.update(image: #imageLiteral(resourceName: "imgKakaofriendsFailure"), info: datas[indexPath.item], size: size)
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
      case 1: headerView.update(with: SectionTitle.new)
      default: headerView.update(with: SectionTitle.zurazuPick)
      }
      
      return headerView
    }

    if kind == UICollectionView.elementKindSectionFooter,
       let footerView: CollectionSeparatorView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "CollectionSeparatorView",
        for: indexPath) as? CollectionSeparatorView {

      return footerView
    }

    return CollectionSeparatorView()
  }
  
}
