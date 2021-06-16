//
//  OrderPaymentInfoViewCell.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/16.
//

import UIKit

class OrderPaymentInfoViewCell: UICollectionViewCell, Reusable {
  
  private let title: UILabel = {
    let label: UILabel = .init()
    label.attributedText = SectionTitle.title(with: "결제 방식")
    
    return label
  }()
  
  private let paymentMethod: UILabel = {
    let label: UILabel = .init()
    label.text = "계좌 이체"
    label.textColor = .monoPrimary
    
    return label
  }()
  
  private let accountInfo: UILabel = {
    let label: UILabel = .init()
    label.text = "주라주 | 국민은행 1234-123453434-1234"
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
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [title, paymentMethod, accountInfo].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: contentView.topAnchor),
      title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
      
      paymentMethod.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 21),
      paymentMethod.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      paymentMethod.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
      
      accountInfo.topAnchor.constraint(equalTo: paymentMethod.bottomAnchor, constant: 8),
      accountInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      accountInfo.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
      accountInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
