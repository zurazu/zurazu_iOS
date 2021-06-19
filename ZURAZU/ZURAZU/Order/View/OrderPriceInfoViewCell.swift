//
//  OrderPriceInfoViewCell.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/16.
//

import UIKit

class OrderPriceInfoViewCell: UICollectionViewCell, Reusable {
  
  private let title: UILabel = {
    let label: UILabel = .init()
    label.attributedText = SectionTitle.title(with: "결제 금액")
    
    return label
  }()
  
  private let info: UILabel = {
    let label: UILabel = .init()
    label.text = "상품 금액"
    label.textColor = .monoPrimary
    
    return label
  }()
  
  private let price: UILabel = {
    let label: UILabel = .init()
    label.textColor = .monoPrimary
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(price: String) {
    self.price.text = price.decimalWon()
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [title, info, price].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    let inset: CGFloat = 16
    
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
      
      title.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -inset),
      title.heightAnchor.constraint(equalToConstant: 20),
      
      info.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 21),
      info.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      info.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -inset),
      info.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
      info.heightAnchor.constraint(equalToConstant: 20),
      
      price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 21),
      price.leadingAnchor.constraint(greaterThanOrEqualTo: info.leadingAnchor),
      price.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
      price.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
