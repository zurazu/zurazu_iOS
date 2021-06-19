//
//  StorageBoxPopUp.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/20.
//

import UIKit

struct StorageBoxPopUpScene: Scene {
  
  var storyboard: String {
    return "StorageBoxPopUp"
  }
  
  func instantiate() -> UIViewController {
    guard var viewController: StorageBoxPopUpViewController = viewController(identifier: .storageBoxPopUpVC) as? StorageBoxPopUpViewController
    else { fatalError() }
    
    let viewModel: StorageBoxPopUpViewModel = .init()
    viewController.bind(viewModel: viewModel)
    
    return viewController
  }
}
