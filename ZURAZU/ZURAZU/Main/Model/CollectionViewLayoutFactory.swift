//
//  CollectionViewLayoutFactory.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/05/29.
//

import UIKit

enum CollectionViewLayoutSectionFactory {
  
  static func horizontalProductSection(headerItem: NSCollectionLayoutBoundarySupplementaryItem? = nil,
                                       footerItem: NSCollectionLayoutBoundarySupplementaryItem? = nil) -> NSCollectionLayoutSection {
    let widthDimension: CGFloat = 0.4
    let heightDimension: CGFloat = CollectionViewLayoutSectionFactory.heightDimensionRatio(with: widthDimension)
    
    // Item
    let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: inset, trailing: 0)
    
    // Group
    let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(widthDimension), heightDimension: .fractionalWidth(heightDimension))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    // Section
    let section: NSCollectionLayoutSection = .init(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    
    // Supplementary Item
    var boundarySupplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
    if let headerItem = headerItem {
      boundarySupplementaryItems.append(headerItem)
    }
    if let footerItem = footerItem {
      boundarySupplementaryItems.append(footerItem)
    }
    section.boundarySupplementaryItems = boundarySupplementaryItems
    
    return section
  }
  
  static func mainProductSection(headerItem: NSCollectionLayoutBoundarySupplementaryItem? = nil,
                                 footerItem: NSCollectionLayoutBoundarySupplementaryItem? = nil) -> NSCollectionLayoutSection {
    let widthDimension: CGFloat = 0.5
    let heightDimension: CGFloat = CollectionViewLayoutSectionFactory.heightDimensionRatio(with: widthDimension)
    
    // Item
    let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(widthDimension), heightDimension: .fractionalWidth(heightDimension))
    let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
    
    // Group
    let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(heightDimension))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    // Section
    let section: NSCollectionLayoutSection = .init(group: group)
    
    // Supplementary Item
    var boundarySupplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
    if let headerItem = headerItem {
      boundarySupplementaryItems.append(headerItem)
    }
    if let footerItem = footerItem {
      boundarySupplementaryItems.append(footerItem)
    }
    section.boundarySupplementaryItems = boundarySupplementaryItems
    
    return section
  }
  
  static let productDetailInfoSection: NSCollectionLayoutSection = {
    let widthDimension: CGFloat = 1
    
    // Item
    let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
    
    // Group
    let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(widthDimension), heightDimension: .estimated(430))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    // Section
    let section: NSCollectionLayoutSection = .init(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: 0, bottom: inset, trailing: 0)
    
    return section
  }()
  
  static let fullScreenHorizontalImageSection: NSCollectionLayoutSection = {
    // Item
    let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
    
    // Group
    let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    // Section
    let section: NSCollectionLayoutSection = .init(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.boundarySupplementaryItems = [detailViewFooterItem]
    
    return section
  }()
  
  static let headerItem: NSCollectionLayoutBoundarySupplementaryItem = {
    let headerItemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
    return .init(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
  }()
  
  static let footerItem: NSCollectionLayoutBoundarySupplementaryItem = {
    let footerItemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.2), heightDimension: .estimated(20))
    return .init(layoutSize: footerItemSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
  }()
  
  static let detailViewFooterItem: NSCollectionLayoutBoundarySupplementaryItem = {
    let footerItemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(255))
    return .init(layoutSize: footerItemSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
  }()
}

private extension CollectionViewLayoutSectionFactory {
  
  static let inset: CGFloat = 20
  
  static func heightDimensionRatio(with widthDimension: CGFloat) -> CGFloat {
    widthDimension * 1.4
  }
}
