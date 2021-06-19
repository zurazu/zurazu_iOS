//
//  FullInfoStackViewItem.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/18.
//

import UIKit

final class FullInfoStackViewItem: UIView {

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

private extension FullInfoStackViewItem {
  
  func setupView() {
    titleLabel.font = .tertiary
    titleLabel.textColor = .monoTertiary
    
    contentLabel.font = .tertiary
    contentLabel.textColor = .monoPrimary
    contentLabel.adjustsFontSizeToFitWidth = true
    contentLabel.numberOfLines = 0
  }
  
  func setupConstraint() {
    [titleLabel, contentLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
      
      contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
      contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
      contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

