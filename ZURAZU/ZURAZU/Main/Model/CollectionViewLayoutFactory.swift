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
    
    // Group
    let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(widthDimension), heightDimension: .fractionalWidth(heightDimension))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
    
    // Section
    let section: NSCollectionLayoutSection = .init(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
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
    item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
    
    // Group
    let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(heightDimension))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    // Section
    let section: NSCollectionLayoutSection = .init(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
    
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
  
  static let transactionHistorySection: NSCollectionLayoutSection = {
    let widthDimension: CGFloat = 1
    
    // Item
    let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
    
    // Group
    let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(widthDimension), heightDimension: .estimated(200))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: 0, bottom: inset, trailing: 0)
    
    // Section
    let section: NSCollectionLayoutSection = .init(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
    
    // Supplementary Item
    section.boundarySupplementaryItems = [headerItem, footerItem]
    
    return section
  }()
  
  static let headerItem: NSCollectionLayoutBoundarySupplementaryItem = {
    let headerItemSize: NSCollectionLayoutSize = .init(widthDimension: .estimated(UIScreen.main.bounds.width - inset * 4), heightDimension: .estimated(20))
    return .init(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
  }()
  
  static let footerItem: NSCollectionLayoutBoundarySupplementaryItem = {
    let footerItemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.2), heightDimension: .estimated(20))
    return .init(layoutSize: footerItemSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
  }()
}

private extension CollectionViewLayoutSectionFactory {
  
  static let inset: CGFloat = 8
  
  static func heightDimensionRatio(with widthDimension: CGFloat) -> CGFloat {
    widthDimension * 1.4
  }
}