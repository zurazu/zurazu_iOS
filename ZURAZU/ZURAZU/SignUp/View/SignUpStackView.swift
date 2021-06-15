//
//  SignUpStackView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/09.
//

import UIKit

final class SignUpStackView: UIStackView {
  
  let emailInputView: InputView = .init(frame: .zero, inputViewType: .email)
  let passwordInputView: InputView = .init(frame: .zero, inputViewType: .password)
  let confirmPasswordInputView: InputView = .init(frame: .zero, inputViewType: .confirmPassword)
  let nameInputView: InputView = .init(frame: .zero, inputViewType: .name)
  let genderLabel: SignUpPickerLabel = .init(frame: .zero)
  let birthLabel: SignUpPickerLabel = .init(frame: .zero)
  let genderPickerView: UIPickerView = .init(frame: .zero)
  let birthPickerView: UIDatePicker = .init(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SignUpStackView {
  
  func setupView() {
    spacing = 25
    axis = .vertical
    alignment = .fill
    
    passwordInputView.textField.isSecureTextEntry = true
    confirmPasswordInputView.textField.isSecureTextEntry = true
    
    addArrangedTitleView(emailInputView, title: "이메일 주소 (ID)", isNecessary: true)
    addArrangedTitleView(passwordInputView, title: "비밀번호", isNecessary: true)
    addArrangedTitleView(confirmPasswordInputView, title: "비밀번호 확인", isNecessary: true)
    addArrangedTitleView(nameInputView, title: "실명", isNecessary: true)
    
    addArrangedTitleView(genderLabel, title: "성별")
    addArrangedTitleView(birthLabel, title: "생년월일")
  }
  
  func addArrangedTitleView(_ view: UIView, title: String, isNecessary: Bool = false) {
    let titleView: TitleView = .init(frame: .zero, contentView: view, isNecessary: isNecessary)
    
    titleView.updateTitle(with: title)
    
    addArrangedSubview(titleView)
  }
}
