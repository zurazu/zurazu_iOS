//
//  TermsOfServiceViewerScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import UIKit

struct TermsOfServiceViewerScene: Scene {
  
  var storyboard: String {
    return "TermsOfServiceViewer"
  }
  
  let termsOfServiceType: TermsOfServiceType
  
  func instantiate() -> UIViewController {
    guard var viewController: TermsOfServiceViewerViewController = viewController(identifier: .termsOfServiceViewerVC) as?
      TermsOfServiceViewerViewController
    else { fatalError() }
    
    let viewModel: TermsOfServiceViewerViewModel = .init(termsOfServiceType: termsOfServiceType)
    viewController.bind(viewModel: viewModel)
    
    return viewController
  }
  
  
}
