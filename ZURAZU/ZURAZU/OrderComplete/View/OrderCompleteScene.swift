//
//  OrderCompleteScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/17.
//

import UIKit

struct OrderCompleteScene: Scene {
  
  var storyboard: String {
    return "OrderComplete"
  }
  
  let orderCompletedProduct: OrderCompletedProduct
  
  func instantiate() -> UIViewController {
    guard var viewController: OrderCompleteViewController = viewController(identifier: .orderCompleteVC) as? OrderCompleteViewController
    else { fatalError() }
    
    let viewModel: OrderCompleteViewModel = .init(orderCompletedProduct: orderCompletedProduct)
    viewController.bind(viewModel: viewModel)
    
    return viewController
  }
}
