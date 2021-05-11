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
      let navigationController = navigationController(identifier: .mainNavC),
      var listViewController = navigationController.viewControllers.first as? MainViewController
    else { fatalError() }
    
    let viewModel = MainViewModel()
    listViewController.bind(viewModel: viewModel)
    
    return navigationController
  }
}
