//
//  CategoryViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import Foundation

protocol CategoryViewModelType {
  
  var categoryTypes: [CategoryType] { get }
}

final class CategoryViewModel: CategoryViewModelType {
  
  var categoryTypes: [CategoryType] = CategoryType.allCases
}
