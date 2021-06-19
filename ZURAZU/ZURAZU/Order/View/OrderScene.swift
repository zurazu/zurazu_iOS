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
  
  var product: Product
  var imageURL: String
  
  func instantiate() -> UIViewController {
    guard var viewController: OrderViewController = viewController(identifier: .orderVC) as? OrderViewController
    else { fatalError() }
    
    let viewModel: OrderViewModel = .init(product: product, imageURL: imageURL)
    viewController.bind(viewModel: viewModel)
    
    return viewController
  }
}
