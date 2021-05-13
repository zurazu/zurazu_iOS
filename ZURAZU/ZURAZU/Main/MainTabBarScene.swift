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
    let tabBarController: UITabBarController = self.tabBarController(identifier: .mainTabBarC)
    
    // MARK: - 화면이 추가된 후 각각의 화면으로 변경해줘야 함
    let categoryScene: UIViewController = MainScene().instantiate()
    categoryScene.tabBarItem = UITabBarItem(title: "카테고리", image: .textAlignLeft, selectedImage: .textAlignLeft)
    
    let logScene: UIViewController = MainScene().instantiate()
    logScene.tabBarItem = UITabBarItem(title: "거래내역", image: .docText, selectedImage: .docTextFill)
    
    let mainScene: UIViewController = SignInScene().instantiate()
    
    let likeScene: UIViewController = MainScene().instantiate()
    likeScene.tabBarItem = UITabBarItem(title: "좋아요", image: .heart, selectedImage: .heartFill)
    
    let myPageScene: UIViewController = MainScene().instantiate()
    myPageScene.tabBarItem = UITabBarItem(title: "마이페이지", image: .person, selectedImage: .personFill)
    
    tabBarController.setViewControllers([categoryScene, logScene, mainScene, likeScene, myPageScene], animated: false)
    
    return tabBarController
  }
}
