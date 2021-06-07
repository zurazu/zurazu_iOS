//
//  SignUpViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/04.
//

import UIKit
import Combine
import CombineCocoa

final class SignUpViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: SignUpViewModelType?
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if isBeingDismissed || isMovingFromParent {
      viewModel?.closeEvent.send()
    }
  }
  
  func bindViewModel() {

  }
}

private extension SignUpViewController {
  
  func setupView() {
    
  }
  
  func setupConstraint() {

  }
}
