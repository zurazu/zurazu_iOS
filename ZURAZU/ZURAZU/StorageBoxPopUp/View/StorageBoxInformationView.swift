//
//  StorageBoxInformationView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/20.
//

import UIKit

final class StorageBoxInformationView: UIView {

  let titleLabel: UILabel = .init(frame: .zero)
  let divider: UIView = .init(frame: .zero)
  let informationTextView: InformationTextView = .init(frame: .zero)
  
  init(frame: CGRect, title: String, information: String) {
    super.init(frame: .zero)
    
    titleLabel.text = "- \(title) -"
    informationTextView.text = information
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension StorageBoxInformationView {
  
  func setupView() {
    titleLabel.font = .tertiaryBold
    titleLabel.textColor = .white
    
    divider.backgroundColor = .white
  }
  
  func setupConstraint() {
    [titleLabel, divider, informationTextView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      titleLabel.heightAnchor.constraint(equalToConstant: 30),
      
      divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
      divider.heightAnchor.constraint(equalToConstant: 1),
      divider.widthAnchor.constraint(equalTo: widthAnchor),
      divider.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
      
      informationTextView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 5),
      informationTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
      informationTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
      informationTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
