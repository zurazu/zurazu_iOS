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
    guard var viewController: SalesApplicationViewController = self.viewController(identifier: .salesApplicationVC) as? SalesApplicationViewController
    else { fatalError() }
    
    let viewModel: SalesApplicationViewModel = .init()
    viewController.bind(viewModel: viewModel)
    
    return viewController
  }
}
