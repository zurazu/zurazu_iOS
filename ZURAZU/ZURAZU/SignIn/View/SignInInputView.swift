//
//  SignInInputView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import UIKit

final class SignInInputView: UIView {
  
  private let emailInputView: InputView = .init(frame: .zero, inputViewType: .email)
  private let passwordInputView: InputView = .init(frame: .zero, inputViewType: .password)
  private let signInLable: UILabel = .init(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SignInInputView {
  
  func setupConstraint() {
    [signInLable, emailInputView, passwordInputView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      signInLable.topAnchor.constraint(equalTo: topAnchor),
      signInLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      signInLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      signInLable.heightAnchor.constraint(equalToConstant: 16),
      
      emailInputView.topAnchor.constraint(equalTo: signInLable.bottomAnchor, constant: 28),
      emailInputView.leadingAnchor.constraint(equalTo: signInLable.leadingAnchor),
      emailInputView.trailingAnchor.constraint(equalTo: signInLable.trailingAnchor),
      emailInputView.heightAnchor.constraint(equalToConstant: 40),
      
      passwordInputView.topAnchor.constraint(equalTo: emailInputView.bottomAnchor, constant: 25),
      passwordInputView.leadingAnchor.constraint(equalTo: emailInputView.leadingAnchor),
      passwordInputView.trailingAnchor.constraint(equalTo: emailInputView.trailingAnchor),
      passwordInputView.heightAnchor.constraint(equalTo: emailInputView.heightAnchor)
      
    ])
  }
  
  func setupView() {
    signInLable.text = "로그인"
    signInLable.font = UIFont.systemFont(ofSize: 13)
  }
}
