//
//  SubCategoryScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/20.
//

import UIKit

struct SubCategoryScene: Scene {
  
  var storyboard: String {
    return "SubCategory"
  }
  
  private let mainCategory: MainCategory
  
  init(mainCategory: MainCategory) {
    self.mainCategory = mainCategory
  }
  
  func instantiate() -> UIViewController {
    guard var subCategoryViewController: SubCategoryViewController = self.viewController(identifier: .subCategoryVC) as? SubCategoryViewController
    else { fatalError() }
    
    let viewModel: SubCategoryViewModel = .init(mainCategory: mainCategory)
    
    subCategoryViewController.bind(viewModel: viewModel)
    
    return subCategoryViewController
  }
}
