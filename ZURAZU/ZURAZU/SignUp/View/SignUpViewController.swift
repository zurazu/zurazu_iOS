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
  private lazy var scrollView: SignUpScrollView = .init(frame: .zero)
  
  private lazy var signUpButton: SignButton = {
    let button: SignButton = .init(frame: .zero)
    
    button.setTitle("회원가입", for: .normal)
    
    return button
  }()
  
  let appPushTermView: TermsOfServiceView = .init(frame: .zero, titleSize: .normal, necessary: .none, title: "앱 알림(앱푸시)")
  let emailTermView: TermsOfServiceView = .init(frame: .zero, titleSize: .normal, necessary: .none, title: "이메일")
  let smsTermView: TermsOfServiceView = .init(frame: .zero, titleSize: .normal, necessary: .none, title: "SMS")
  let kakaoTalkTermView: TermsOfServiceView = .init(frame: .zero, titleSize: .normal, necessary: .none, title: "카카오톡")
  
  let zurazuTermView : TermsOfServiceView = .init(frame: .zero, titleSize: .normal, necessary: .necessary, title: "ZURAZU 이용약관에 동의합니다.")
  let personalInformationTermView : TermsOfServiceView = .init(frame: .zero, titleSize: .normal, necessary: .necessary, title: " ZURAZU 개인정보 수집 및 이용에 동의합니다.")
  lazy var marketingTermView: TermsOfServiceView = .init(frame: .zero, title: "ZURAZU 마케팅 정보 수신에 동의합니다.", titleSize: .normal, necessary: .choosable, childAxis: .vertical, childViews: [appPushTermView, emailTermView, smsTermView, kakaoTalkTermView])
  let ageTermView : TermsOfServiceView = .init(frame: .zero, titleSize: .normal, necessary: .necessary, title: "만 14세 미만이 아닙니다.")
  
  lazy var termsOfServiceView: TermsOfServiceView = .init(frame: .zero, title: "전체 동의", titleSize: .large, necessary: .none, childAxis: .vertical, childViews: [zurazuTermView, personalInformationTermView, marketingTermView, ageTermView])
  
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
    
    stackView.nameInputView.textField
      .textPublisher
      .compactMap { $0 }
      .sink { [weak self] in
        self?.viewModel?.name.send($0)
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
    
    signUpButton
      .tapPublisher
      .sink { [weak self] in
        self?.viewModel?.signUpEvent.send()
      }
      .store(in: &cancellables)
    
    stackView.emailInputView.textField
      .returnPublisher
      .sink { [weak self] in
        self?.stackView.passwordInputView.textField.becomeFirstResponder()
      }
      .store(in: &cancellables)
    
    stackView.passwordInputView.textField
      .returnPublisher
      .sink { [weak self] in
        self?.stackView.confirmPasswordInputView.textField.becomeFirstResponder()
      }
      .store(in: &cancellables)
    
    stackView.confirmPasswordInputView.textField
      .returnPublisher
      .sink { [weak self] in
        self?.stackView.nameInputView.textField.becomeFirstResponder()
      }
      .store(in: &cancellables)
    
    stackView.nameInputView.textField
      .returnPublisher
      .sink { [weak self] in
        self?.stackView.nameInputView.textField.resignFirstResponder()
        self?.scrollView.setContentOffset(CGPoint(x: 0, y: -36), animated: true)
      }
      .store(in: &cancellables)
    
    bindWithTermsOfServiceView()
  }
}

private extension SignUpViewController {
  
  func setupView() {
    title = "회원가입"
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
    
    stackView.emailInputView.delegate = scrollView
    stackView.passwordInputView.delegate = scrollView
    stackView.confirmPasswordInputView.delegate = scrollView
    stackView.nameInputView.delegate = scrollView
    
    scrollView.delegate = self
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func setupConstraint() {
    [scrollView, signUpButton, termsOfServiceView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    scrollView.addSubview(stackView)
    scrollView.addSubview(termsOfServiceView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      
      termsOfServiceView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
      termsOfServiceView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      termsOfServiceView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      termsOfServiceView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      
      signUpButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
      signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
      signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      signUpButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
  
  func bindWithTermsOfServiceView() {
    zurazuTermView.publisher(for: \.isSelected)
      .removeDuplicates()
      .sink { [weak self] in
        self?.viewModel?.isAgreedZurazuTermOfService.send($0)
      }
      .store(in: &cancellables)
    
    personalInformationTermView.publisher(for: \.isSelected)
      .removeDuplicates()
      .sink { [weak self] in
        self?.viewModel?.isAgreedPersonalInformation.send($0)
      }
      .store(in: &cancellables)
    
    appPushTermView.publisher(for: \.isSelected)
      .removeDuplicates()
      .sink { [weak self] in
        self?.viewModel?.isAgreedPushNotification.send($0)
      }
      .store(in: &cancellables)
    
    emailTermView.publisher(for: \.isSelected)
      .removeDuplicates()
      .sink { [weak self] in
        self?.viewModel?.isAgreedReceiveEmail.send($0)
      }
      .store(in: &cancellables)
    
    smsTermView.publisher(for: \.isSelected)
      .removeDuplicates()
      .sink { [weak self] in
        self?.viewModel?.isAgreedReceiveSMS.send($0)
      }
      .store(in: &cancellables)
    
    kakaoTalkTermView.publisher(for: \.isSelected)
      .removeDuplicates()
      .sink { [weak self] in
        self?.viewModel?.isAgreedReceiveKakaoTalk.send($0)
      }
      .store(in: &cancellables)
    
    ageTermView.publisher(for: \.isSelected)
      .removeDuplicates()
      .sink { [weak self] in
        self?.viewModel?.isAgreedUpperFourteen.send($0)
      }
      .store(in: &cancellables)
    
  }
  
  @objc func keyboardWillHide() {
    scrollView.setLastContentOffset()
  }
}

extension SignUpViewController: UIScrollViewDelegate {
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}
