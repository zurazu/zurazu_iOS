//
//  InputCollectionViewCell.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/25.
//

import UIKit

final class InputCollectionViewCell: UICollectionViewCell {

  let textField: UnderLineTextField =  {
    let textField = UnderLineTextField()
    textField.font = .tertiary
    return textField
  }()
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .tertiary
    label.textColor = .monoQuaternary
    return label
  }()
  private let stackView: UIStackView =  {
    let stackView = UIStackView()
    stackView.axis = .vertical
    return stackView
  }()
  private let marginView: UIView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
}

extension InputCollectionViewCell {
  
  func setPlaceHolder(message: String?) {
    textField.placeholder = message
  }
  
  func setDescriptionLabel(message: String?) {
    descriptionLabel.text = message
    marginView.isHidden = (message?.isEmpty) ?? true
  }
}

private extension InputCollectionViewCell {
  
  func configure() {
    addSubview(stackView)
    
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    marginView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.addArrangedSubview(textField)
    stackView.addArrangedSubview(marginView)
    NSLayoutConstraint.activate([stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                 stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                 stackView.topAnchor.constraint(equalTo: topAnchor),
                                 stackView.bottomAnchor.constraint(equalTo: bottomAnchor)])

    marginView.addSubview(descriptionLabel)
    NSLayoutConstraint.activate([marginView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 4),
                                 marginView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: -4),
                                 marginView.topAnchor.constraint(equalTo: descriptionLabel.topAnchor),
                                 marginView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor)])
    marginView.isHidden = true
  }
  

}

