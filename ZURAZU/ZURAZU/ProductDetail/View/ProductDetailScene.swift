//
//  ProductDetailScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/26.
//

import UIKit

struct ProductDetailScene: Scene {
  
  var storyboard: String
  
  func instantiate() -> UIViewController {
    guard var productDetailViewController: ProductDetailViewController = self.viewController(identifier: .productDetailVC) as? ProductDetailViewController
    else { fatalError() }
    
    let viewModel: ProductDetailViewModel = .init()
    productDetailViewController.bind(viewModel: viewModel)
    
    return productDetailViewController
  }
}
