//
//  SalesApplicationCompleteScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/17.
//

import UIKit

struct SalesApplicationCompleteScene: Scene {
  
  var storyboard: String {
    return "SalesApplicationComplete"
  }
  
  func instantiate() -> UIViewController {
    guard var viewController: SalesApplicationCompleteViewController = viewController(identifier: .salesApplicationCompleteVC) as? SalesApplicationCompleteViewController
    else { fatalError() }
    
    let viewModel: SalesApplicationCompleteViewModel = .init()
    viewController.bind(viewModel: viewModel)
    
    return viewController
  }
}
