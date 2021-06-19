//
//  OrderScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/19.
//

import UIKit

struct OrderScene: Scene {
  
  var storyboard: String {
    return "Order"
  }
  
  func instantiate() -> UIViewController {
    guard var viewController: OrderViewController = viewController(identifier: .orderVC) as? OrderViewController
    else { fatalError() }
    
    let viewModel: OrderViewModel = .init()
    viewController.bind(viewModel: viewModel)
    
    return viewController
  }
}
