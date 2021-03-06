//
//  SceneDelegate.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    
    guard let window: UIWindow = window else { return }
    
    window.overrideUserInterfaceStyle = .light
    
    SceneCoordinator.shared.setup(with: window)
    SceneCoordinator.shared.transition(
      scene: MainTabBarScene(),
      using: .root,
      animated: false
    )
    SceneCoordinator.shared.tabTransition()
       window.makeKeyAndVisible()
//   SceneCoordinator.shared.transition(scene: SalesApplicationScene(), using: .root, animated: false)
    SceneCoordinator.shared.tabTransition(item: .category)
    window.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) { }

  func sceneDidBecomeActive(_ scene: UIScene) { }

  func sceneWillResignActive(_ scene: UIScene) { }

  func sceneWillEnterForeground(_ scene: UIScene) { }

  func sceneDidEnterBackground(_ scene: UIScene) { }

}
