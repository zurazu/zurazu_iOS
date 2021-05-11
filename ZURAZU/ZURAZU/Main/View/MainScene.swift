//
//  MainScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import Foundation

struct MainScene: Scene {
  
  var storyboard: String {
    return "Main"
  }
  
  func instantiate() -> UIViewController {
    let storyboard = UIStoryboard(name: self.storyboard, bundle: nil)

    guard
      let navigationController = storyboard.instantiateViewController(identifier: "MainNavigationController") as? UINavigationController,
      var listViewController = navigationController.viewControllers.first as? MainViewController
    else { fatalError() }
    let viewModel = MainViewModel()
    listViewController.bind(viewModel: viewModel)
    
    return navigationController
  }
}
