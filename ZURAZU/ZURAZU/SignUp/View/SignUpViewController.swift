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
    let button: UIButton = .init(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  let stackView: SignUpStackView = .init(frame: .zero)
  private lazy var scrollView: UIScrollView = {
    let scrollView: UIScrollView = .init(frame: .zero)
    
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.contentInset = UIEdgeInsets(top: 36, left: 0, bottom: 36, right: 0)
    
    return scrollView
  }()
  
  private lazy var signUpButton: SignButton = {
    let button: SignButton = .init(frame: .zero)
    
    button.setTitle("회원가입", for: .normal)
    
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
    tabBarController?.tabBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    navigationController?.setNavigationBarHidden(true, animated: animated)
    tabBarController?.tabBar.isHidden = false
  }
  
  func bindViewModel() {
    backButton
      .tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
    
    signUpButton
      .tapPublisher
      .sink {
        
      }
      .store(in: &cancellables)
    
    stackView.emailInputView.textField
      .textPublisher
      .compactMap { $0 }
      .filter { !$0.isEmpty }
      .sink { [weak self] in
        self?.viewModel?.email.send($0)
      }
      .store(in: &cancellables)
    
    stackView.passwordInputView.textField
      .textPublisher
      .compactMap { $0 }
      .sink { [weak self] in
        self?.viewModel?.password.send($0)
      }
      .store(in: &cancellables)
    
    stackView.confirmPasswordInputView.textField
      .textPublisher
      .compactMap { $0 }
      .sink { [weak self] in
        self?.viewModel?.confirmPassword.send($0)
      }
      .store(in: &cancellables)
    
    viewModel?.isValid
      .receive(on: Scheduler.main)
      .removeDuplicates()
      .sink {
        self.signUpButton.isEnabled = $0
      }
      .store(in: &cancellables)
    
    viewModel?.isEmailValid
      .receive(on: Scheduler.main)
      .removeDuplicates()
      .sink { [weak self] in
        self?.stackView.emailInputView.showMessage(with: $0)
      }
      .store(in: &cancellables)
    
    viewModel?.isPasswordValid
      .receive(on: Scheduler.main)
      .removeDuplicates()
      .sink { [weak self] in
        self?.stackView.passwordInputView.showMessage(with: $0)
      }
      .store(in: &cancellables)
    
    viewModel?.isConfirmPasswordValid
      .receive(on: Scheduler.main)
      .removeDuplicates()
      .sink { [weak self] in
        self?.stackView.confirmPasswordInputView.showMessage(with: $0)
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
    [scrollView, signUpButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    scrollView.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      
      signUpButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
      signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
      signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      signUpButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
}
