//
//  GuestGuideView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/08.
//

import UIKit

final class GuestGuideView: UIView {
  
  lazy var signInButton: UIButton = {
    let button: UIButton = .init(frame: .zero)
    
    button.backgroundColor = .bluePrimary
    button.titleLabel?.font = .primaryBold
    button.setTitle("로그인 하기", for: .normal)
    button.setTitleColor(.background, for: .normal)
    
    return button
  }()
  
  private lazy var currentStateLabel: UILabel = {
    let label: UILabel = .init(frame: .zero)
    
    label.font = .biggestBold
    label.textColor = .monoPrimary
    label.text = "현재 로그아웃 상태입니다."
    
    return label
  }()
  
  private lazy var guideLabel: UILabel = {
    let label: UILabel = .init(frame: .zero)
    
    label.font = .secondary
    label.textColor = .monoPrimary
    label.text = "로그인 해주세요."
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension GuestGuideView {
  
  func setupView() {
    backgroundColor = .white
  }
  
  func setupConstraint() {
    [signInButton, currentStateLabel, guideLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      currentStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      currentStateLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      currentStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
      
      guideLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      guideLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      guideLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      signInButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      signInButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
      signInButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
}
