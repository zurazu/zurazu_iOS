//
//  SignButton.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/03.
//

import UIKit

final class SignButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isEnabled: Bool {
    didSet {
      updateButton(with: isEnabled)
    }
  }
}

private extension SignButton {
  
  func setupView() {
    backgroundColor = .bluePrimary
    titleLabel?.font = .primaryBold
    setTitleColor(.background, for: .normal)
    
    isEnabled = false
  }
  
  func updateButton(with isValid: Bool) {
    isValid ? changeEnabled() : changeDisabled()
  }
  
  func changeEnabled() {
    backgroundColor = .bluePrimary
  }
  
  func changeDisabled() {
    backgroundColor = .blueSecondary
  }
}
