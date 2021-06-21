//
//  ChoiceCollectionViewCell.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/25.
//

import UIKit
import Combine

final class PickerCollectionViewCell: UICollectionViewCell {
  
  var cancellables: Set<AnyCancellable> = []
  let borderView: UIView = {
    let view: UIView = .init()
    
    view.layer.borderWidth = 1
    view.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    
    return view
  }()
  
  let textField: UITextField = {
    let textField: UITextField = .init()
    
    textField.font = .tertiary
    textField.placeholder = "선택해주세요"
    
    return textField
  }()
  
  let imageView: UIImageView = {
    let imageView: UIImageView = .init()
    
    imageView.image = UIImage(systemName: "chevron.down")
    imageView.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    
    return imageView
  }()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cancellables = []
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
}

extension PickerCollectionViewCell {
  
}

private extension PickerCollectionViewCell {
  
  func configure() {
    addSubview(borderView)
    borderView.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    borderView.addSubview(textField)
    borderView.addSubview(imageView)
    
    NSLayoutConstraint.activate([borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                 borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                 borderView.topAnchor.constraint(equalTo: topAnchor),
                                 borderView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    
    NSLayoutConstraint.activate([
      textField.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15),
      textField.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15),
      textField.topAnchor.constraint(equalTo: borderView.topAnchor),
      textField.bottomAnchor.constraint(equalTo: borderView.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([imageView.heightAnchor.constraint(equalToConstant: 16),
                                 imageView.widthAnchor.constraint(equalToConstant: 16),
                                 imageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -12),
                                 imageView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor)])
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapButton(sender:)))
    
    contentView.isUserInteractionEnabled = true
    contentView.addGestureRecognizer(tapGesture)
  }
  
  @objc func tapButton(sender: UITapGestureRecognizer) {
    textField.becomeFirstResponder()
  }
  
}

