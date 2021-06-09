//
//  TitleView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/09.
//

import UIKit

final class TitleView: UIView {

  lazy var titleLabel: UILabel = {
    let label: UILabel = .init(frame: .zero)
    
    label.font = .primaryBold
    label.textColor = .monoPrimary
    
    return label
  }()
  
  lazy var necessaryLabel: UILabel = {
    let label: UILabel = .init(frame: .zero)
    
    label.font = .quaternaryBold
    label.textColor = .redPrimary
    label.text = " *"
    
    return label
  }()
  
  let contentView: UIView
  
  init(frame: CGRect, contentView: UIView, isNecessary: Bool = false) {
    self.contentView = contentView
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateTitle(with title: String) {
    titleLabel.text = title
  }
}

private extension TitleView {
  
  func setupView() {

  }
  
  func setupConstraint() {
    [titleLabel, necessaryLabel, contentView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      
      necessaryLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      
      contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
      contentView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
      contentView.heightAnchor.constraint(equalToConstant: 40),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
