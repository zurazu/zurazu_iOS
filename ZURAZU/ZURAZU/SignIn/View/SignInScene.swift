//
//  SignInScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import UIKit

struct SignInScene: Scene {
  
  var storyboard: String {
    return "SignIn"
  }
  
  func instantiate() -> UIViewController {
    guard var signInViewController: SignInViewController = viewController(identifier: .signInVC) as? SignInViewController else { fatalError() }
    
    let viewModel: SignInViewModel = .init()
    signInViewController.bind(viewModel: viewModel)
    
    return signInViewController
  }
}
