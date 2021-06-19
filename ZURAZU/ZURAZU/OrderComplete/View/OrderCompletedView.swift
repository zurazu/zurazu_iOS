//
//  OrderCompletedView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import UIKit

final class OrderCompletedView: UIView {

  let titleLabel: UILabel = .init(frame: .zero)
  let contentLabel: UILabel = .init(frame: .zero)
  
  init(frame: CGRect, title: String) {
    super.init(frame: frame)
    
    titleLabel.text = title
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateContent(with text: String) {
    contentLabel.text = text
  }
}

private extension OrderCompletedView {
  
  func setupView() {
    titleLabel.font = .tertiaryBold
    titleLabel.textColor = .monoPrimary
    
    contentLabel.font = .tertiary
    contentLabel.textColor = .monoPrimary
    contentLabel.adjustsFontSizeToFitWidth = true
  }
  
  func setupConstraint() {
    [titleLabel, contentLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
      
      contentLabel.lastBaselineAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor),
      contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      contentLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
    ])
  }
}
