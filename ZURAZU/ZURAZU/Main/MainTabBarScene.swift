//
//  MainTabBarScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/12.
//

import UIKit

struct MainTabBarScene: Scene {
  
  var storyboard: String {
    return "MainTabBar"
  }
  
  func instantiate() -> UIViewController {
    guard var tabBarController: MainTabBarController = self.tabBarController(identifier: .mainTabBarC) as? MainTabBarController
    else { fatalError() }
    
    let viewModel: MainTabBarViewModel = .init()
    tabBarController.bind(viewModel: viewModel)
    // MARK: - 화면이 추가된 후 각각의 화면으로 변경해줘야 함
    
    var viewControllers: [UIViewController] = []
    
    TabItem.allCases.enumerated().forEach { index, item in
      let scene: UIViewController = item.scene.instantiate()
      
      viewControllers.append(scene)
      
      if index != TabItem.allCases.centerIndex {
        scene.tabBarItem = UITabBarItem(title: item.title, image: item.image, selectedImage: item.selectedImage)
      }
    }
    
    tabBarController.setViewControllers(viewControllers, animated: false)
    
    return tabBarController
  }
}
