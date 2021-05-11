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
  
  func navigationController(identifier: SceneIdentifier) -> UINavigationController? {
    let storyboard = UIStoryboard(name: self.storyboard, bundle: nil)
    
    let navigationController = storyboard.instantiateViewController(identifier: identifier.rawValue) as? UINavigationController
    
    return navigationController
  }
  
  func viewController(identifier: SceneIdentifier) -> UIViewController {
    let storyboard = UIStoryboard(name: self.storyboard, bundle: nil)
    let viewController = storyboard.instantiateViewController(identifier: identifier.rawValue)
    
    return viewController
  }
}
