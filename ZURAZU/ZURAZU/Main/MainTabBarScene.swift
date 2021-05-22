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
  
  var sceneCoordinator: SceneCoordinatorType
  
  func instantiate() -> UIViewController {
    guard var tabBarController: MainTabBarController = self.tabBarController(identifier: .mainTabBarC) as? MainTabBarController
    else { fatalError() }
    
    let viewModel: MainTabBarViewModel = .init(sceneCoordinator: sceneCoordinator)
    tabBarController.bind(viewModel: viewModel)
    // MARK: - 화면이 추가된 후 각각의 화면으로 변경해줘야 함
    let categoryScene: UIViewController = CategoryScene().instantiate()
    categoryScene.tabBarItem = UITabBarItem(title: "카테고리", image: .textAlignLeft, selectedImage: .textAlignLeft)
    
    let logScene: UIViewController = MainScene().instantiate()
    logScene.tabBarItem = UITabBarItem(title: "거래내역", image: .docText, selectedImage: .docTextFill)
    
    let mainScene: UIViewController = MainScene().instantiate()
    
    let likeScene: UIViewController = MainScene().instantiate()
    likeScene.tabBarItem = UITabBarItem(title: "좋아요", image: .heart, selectedImage: .heartFill)
    
    let myPageScene: UIViewController = MainScene().instantiate()
    myPageScene.tabBarItem = UITabBarItem(title: "마이페이지", image: .person, selectedImage: .personFill)
    
    tabBarController.setViewControllers([categoryScene, logScene, mainScene, likeScene, myPageScene], animated: false)
    
    return tabBarController
  }
}
