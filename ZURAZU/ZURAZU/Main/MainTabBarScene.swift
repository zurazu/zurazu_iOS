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
    let tabBarController = self.tabBarController(identifier: .mainTabBarC)
    
    // MARK: - 화면이 추가된 후 각각의 화면으로 변경해줘야 함
    let categoryScene = MainScene().instantiate()
    let logScene = MainScene().instantiate()
    let mainScene = MainScene().instantiate()
    let likeScene = MainScene().instantiate()
    let myPageScene = MainScene().instantiate()
    
    tabBarController.setViewControllers([categoryScene, logScene, mainScene, likeScene, myPageScene], animated: false)
    
    // MARK: - 로직 정리해야 함.
    tabBarController.tabBar.items?.enumerated().forEach {
      if $0 != 2 {
        $1.image = UIImage(systemName: "person")
        $1.image?.withTintColor(.red)
      }
    }
    
    return tabBarController
  }
}
