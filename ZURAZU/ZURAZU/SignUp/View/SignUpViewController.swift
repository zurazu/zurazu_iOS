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
  
  private lazy var backButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  func bindViewModel() {
    backButton
      .tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
  }
}

private extension SignUpViewController {
  
  func setupView() {
    title = "회원가입"
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  func setupConstraint() {

  }
}
