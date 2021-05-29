//
//  CategoryScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit

struct CategoryScene: Scene {
  
  var storyboard: String {
    return "Category"
  }
  var sceneCoordinator: SceneCoordinatorType
  
  func instantiate() -> UIViewController {
    let navigationController: UINavigationController = self.navigationController(identifier: .categoryNavC)
    
    guard var categoryViewController: CategoryViewController = navigationController.viewControllers.first as? CategoryViewController
    else { fatalError() }
    
    let viewModel: CategoryViewModel = .init(sceneCoordinator: sceneCoordinator)
    categoryViewController.bind(viewModel: viewModel)
    
    return navigationController
  }
}
