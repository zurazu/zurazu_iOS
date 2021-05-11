//
//  OptionStackView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import UIKit

final class OptionStackView: UIStackView {
  
  private let signUpButton: OptionButton = .init(title: "이메일 가입")
  private let findPasswordButton: OptionButton = .init(title: "이메일 찾기")
  private let findEmailButton: OptionButton = .init(title: "비밀번호 찾기")
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension OptionStackView {
  
  func setupView() {
    spacing = 10
    axis = .horizontal
    alignment = .fill
    
    
    addArrangedSubview(signUpButton)
    makeDivider()
    addArrangedSubview(findPasswordButton)
    makeDivider()
    addArrangedSubview(findEmailButton)
    
  }
  
  func makeDivider() {
    let divider: UIView = .init(frame: .zero)
    
    divider.backgroundColor = .black
    
    addArrangedSubview(divider)
    
    divider.widthAnchor.constraint(equalToConstant: 1).isActive = true
    divider.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
  }
}