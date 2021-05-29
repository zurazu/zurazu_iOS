//
//  ItemDetailScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/26.
//

import UIKit

struct ItemDetailScene: Scene {
  
  var storyboard: String
  
  func instantiate() -> UIViewController {
    guard var itemDetailViewController: ItemDetailViewController = self.viewController(identifier: .ItemDetailVC) as? ItemDetailViewController
    else { fatalError() }
    
    let viewModel: ItemDetailViewModel = .init()
    itemDetailViewController.bind(viewModel: viewModel)
    
    return itemDetailViewController
  }
}
