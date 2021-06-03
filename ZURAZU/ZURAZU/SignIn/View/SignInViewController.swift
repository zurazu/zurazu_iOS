//
//  SignInViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import UIKit
import Combine
import CombineCocoa

final class SignInViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: SignInViewModelType?
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let closeButton: UIButton = .init(frame: .zero)
  private let logoImageView: UIImageView = .init(frame: .zero)
  private let signInInputView: SignInInputView = .init(frame: .zero)
  private let signInButton: SignInButton = .init(frame: .zero)
  private let optionStackView: OptionStackView = .init(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
    bind()
  }
  
  func bind() {
    
  }
  
  func bindViewModel() {
    
    viewModel?.isValid
      .receive(on: Scheduler.main)
      .removeDuplicates()
      .assign(to: \.isEnabled, on: signInButton)
      .store(in: &cancellables)
    
    viewModel?.isEmailValid
      .receive(on: Scheduler.main)
      .removeDuplicates()
      .sink { self.signInInputView.emailInputView.showMessage(with: $0) }
      .store(in: &cancellables)
    
    viewModel?.isPasswordValid
      .receive(on: Scheduler.main)
      .removeDuplicates()
      .sink { self.signInInputView.passwordInputView.showMessage(with: $0) }
      .store(in: &cancellables)
    
    signInInputView.emailInputView.textField
      .textPublisher
      .compactMap { $0 }
      .filter { !$0.isEmpty }
      .sink { [weak self] in
        self?.viewModel?.email.send($0)
      }
      .store(in: &cancellables)
    
    signInInputView.passwordInputView.textField
      .textPublisher
      .compactMap { $0 }
      .filter { !$0.isEmpty }
      .sink { [weak self] in
        self?.viewModel?.password.send($0)
      }
      .store(in: &cancellables)
  }
}

private extension SignInViewController {
  
  func setupConstraint() {
    [closeButton, logoImageView, signInInputView, signInButton, optionStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      closeButton.widthAnchor.constraint(equalToConstant: 18),
      closeButton.heightAnchor.constraint(equalToConstant: 24),
      
      logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.2),
      logoImageView.widthAnchor.constraint(equalToConstant: 153),
      logoImageView.heightAnchor.constraint(equalToConstant: 26),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      signInInputView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 97),
      signInInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      signInInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      signInInputView.heightAnchor.constraint(equalToConstant: 160),
      
      signInButton.topAnchor.constraint(equalTo: signInInputView.bottomAnchor, constant: 20),
      signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      signInButton.heightAnchor.constraint(equalToConstant: 44),
      
      optionStackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17),
      optionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      optionStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      optionStackView.heightAnchor.constraint(equalToConstant: 16)
    ])
  }
  
  func setupView() {
    closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
    closeButton.backgroundColor = .background
    closeButton.tintColor = .black
    
    logoImageView.image = #imageLiteral(resourceName: "zurazuLogoImage")
  }
}
