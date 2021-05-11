//
//  MainScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import UIKit

struct MainScene: Scene {
  
  var storyboard: String {
    return "Main"
  }
  
  func instantiate() -> UIViewController {
    guard
      let navigationController: UINavigationController = navigationController(identifier: .mainNavC),
      var listViewController: MainViewController = navigationController.viewControllers.first as? MainViewController
    else { fatalError() }
    
    let viewModel: MainViewModel = .init()
    listViewController.bind(viewModel: viewModel)
    
    return navigationController
  }
}
