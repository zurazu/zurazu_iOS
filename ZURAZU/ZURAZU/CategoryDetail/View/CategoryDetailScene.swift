//
//  CategoryDetailScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/20.
//

import UIKit

struct CategoryDetailScene: Scene {
  
  var storyboard: String {
    return "CategoryDetail"
  }
  
  func instantiate() -> UIViewController {
    guard var categoryDetailViewController: CategoryDetailViewController = self.viewController(identifier: .categoryDetailVC) as? CategoryDetailViewController
    else { fatalError() }
    
    let viewModel: CategoryDetailViewModel = .init()
    
    categoryDetailViewController.bind(viewModel: viewModel)
    
    return categoryDetailViewController
  }
}
