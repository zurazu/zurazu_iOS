//
//  UnpreparedScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/19.
//

import UIKit

struct UnpreparedScene: Scene {
  
  var storyboard: String {
    return "Unprepared"
  }
  
  private let title: String
  
  init(title: String) {
    self.title = title
  }
  
  func instantiate() -> UIViewController {
    let navigationController: UINavigationController = self.navigationController(identifier: .unpreparedNavC)
    
    guard let viewController: UnpreparedViewController = navigationController.viewControllers.first as? UnpreparedViewController
    else { fatalError() }
    
    viewController.title = title
    
    return navigationController
  }
}
