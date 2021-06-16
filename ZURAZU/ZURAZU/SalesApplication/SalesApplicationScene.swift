//
//  SalesApplicationScene.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/26.
//

import UIKit

struct SalesApplicationScene: Scene {

  var storyboard: String {
    return "SalesApplication"
  }

  func instantiate() -> UIViewController {
    let viewController: UIViewController = self.viewController(identifier: .salesApplicationVC)
    
    return viewController
  }
}
