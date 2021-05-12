//
//  Scene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/10.
//

import UIKit

protocol Scene {
  
  var storyboard: String { get }
  
  func instantiate() -> UIViewController
}

extension Scene {
  
  func navigationController(identifier: SceneIdentifier) -> UINavigationController {
    let storyboard: UIStoryboard = .init(name: self.storyboard, bundle: nil)
    let navigationController: UINavigationController = storyboard.instantiateViewController(identifier: identifier.rawValue)
    
    return navigationController
  }
  
  func viewController(identifier: SceneIdentifier) -> UIViewController {
    let storyboard: UIStoryboard = .init(name: self.storyboard, bundle: nil)
    let viewController: UIViewController = storyboard.instantiateViewController(identifier: identifier.rawValue)
    
    return viewController
  }
  
  func tabBarController(identifier: SceneIdentifier) -> UITabBarController {
    let storyboard: UIStoryboard = .init(name: self.storyboard, bundle: nil)
    let tabBarConroller: UITabBarController = storyboard.instantiateViewController(identifier: identifier.rawValue)
    
    return tabBarConroller
  }
}
