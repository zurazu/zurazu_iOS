//
//  CommentCollectionViewCell.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/25.
//

import UIKit
import Combine

final class CommentCollectionViewCell: UICollectionViewCell {

  var cancellables: Set<AnyCancellable> = []
  
  let borderView: UIView = {
    let view: UIView = .init()
    
    view.layer.borderWidth = 1
    view.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    
    return view
  }()
  
  let textField: UITextField =  {
    let textField: UITextField = .init()
    
    textField.font = .tertiary
    textField.textAlignment = .left
    textField.contentVerticalAlignment = .top
    
    return textField
  }()
  

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cancellables = []
  }
}

extension CommentCollectionViewCell {
  
  func updatePlaceHolder(message: String?) {
    textField.placeholder = message
  }
  

}

private extension CommentCollectionViewCell {
  
  func configure() {
    addSubview(borderView)

    borderView.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    borderView.addSubview(textField)
    
    NSLayoutConstraint.activate([borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                 borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                 borderView.topAnchor.constraint(equalTo: topAnchor),
                                 borderView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    
    NSLayoutConstraint.activate([borderView.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
                                 borderView.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -10),
                                 borderView.topAnchor.constraint(equalTo: textField.topAnchor, constant: -10),
                                 borderView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10)])
  }
}

