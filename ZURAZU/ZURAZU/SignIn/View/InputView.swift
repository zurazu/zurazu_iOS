//
//  InputView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import UIKit

final class InputView: UIView {
  
  let textField: UITextField = .init(frame: .zero)
  private let line: UIView = .init(frame: .zero)
  private let messageLabel: UILabel = .init(frame: .zero)
  
  private let inputViewType: InputViewType
  
  init(frame: CGRect, inputViewType: InputViewType) {
    self.inputViewType = inputViewType
    super.init(frame: frame)

    self.setupView()
    self.setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func showMessage(with isValid: Bool) {
    isValid ? showValidMessage() : showInvalidMessage()
  }
}

private extension InputView {
  
  func setupConstraint() {
    [textField, line, messageLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      textField.topAnchor.constraint(equalTo: topAnchor),
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
      textField.heightAnchor.constraint(equalToConstant: 24),
      
      line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 6),
      line.heightAnchor.constraint(equalToConstant: 1),
      line.leadingAnchor.constraint(equalTo: leadingAnchor),
      line.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      messageLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
      messageLabel.heightAnchor.constraint(equalToConstant: 12)
    ])
  }
  
  func setupView() {
    textField.clearButtonMode = .always
    
    textField.placeholder = inputViewType.placeHolder
    textField.layer.borderColor = .none
    textField.backgroundColor = .background
    
    messageLabel.textColor = .redPrimary
    messageLabel.font = .systemFont(ofSize: 12)
    
    line.backgroundColor = .monoQuaternary
  }
  
  func showValidMessage() {
    messageLabel.text = .none
    line.backgroundColor = .monoQuaternary
  }
  
  func showInvalidMessage() {
    messageLabel.text = inputViewType.invalidMessage
    line.backgroundColor = .redPrimary
  }
}
