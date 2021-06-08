//
//  NotSignInView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/08.
//

import UIKit

final class NotSignInView: UIView {
  
  private lazy var currentStateLabel: UILabel = {
    let label: UILabel = .init(frame: .zero)
    
    label.font = .biggestBold
    label.textColor = .monoPrimary
    label.text = "현재 로그아웃 상태입니다."
    
    return label
  }()
  
  private lazy var indicateLabel: UILabel = {
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

private extension NotSignInView {
  
  func setupView() {
    backgroundColor = .white
  }
  
  func setupConstraint() {
    [currentStateLabel, indicateLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      currentStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      currentStateLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      currentStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
      
      indicateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      indicateLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      indicateLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30),
    ])
  }
}
