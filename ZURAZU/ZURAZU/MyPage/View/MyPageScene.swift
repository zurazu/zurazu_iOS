//
//  MyPageScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import UIKit

struct MyPageScene: Scene {
  
  var storyboard: String {
    return "MyPage"
  }
  
  func instantiate() -> UIViewController {
    let navigationController: UINavigationController = self.navigationController(identifier: .myPageNavC)
    
    guard var myPageViewController: MyPageViewController = navigationController.viewControllers.first as? MyPageViewController
    else { fatalError() }
    
    let viewModel: MyPageViewModel = .init()
    myPageViewController.bind(viewModel: viewModel)
    
    return navigationController
  }
}
