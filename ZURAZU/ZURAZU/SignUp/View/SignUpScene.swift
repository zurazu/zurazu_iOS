//
//  SignUpScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/04.
//

import UIKit

struct SignUpScene: Scene {
  
  var storyboard: String {
    return "SignUp"
  }
  
  func instantiate() -> UIViewController {
    guard var signUpViewController: SignUpViewController = viewController(identifier: .signUpVC) as? SignUpViewController else { fatalError() }
    
    let viewModel: SignUpViewModel = .init()
    signUpViewController.bind(viewModel: viewModel)
    
    return signUpViewController
  }
}
