//
//  ProductThumbnailInfoView.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/05/28.
//

import UIKit

final class ProductThumbnailInfoView: UIView {
  
  private let brandName: UILabel = .init()
  private let name: UILabel = .init()
  private let price: UILabel = .init()
  
  private var info: ProductThumbnailInfo?
  private var size: ProductThumbnailSize?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(info: ProductThumbnailInfo, size: ProductThumbnailSize) {
    self.info = info
    self.size = size
    
    setupFont()
  }
}

extension ProductThumbnailInfoView {
  
  private func setupFont() {
    guard let size = size else { return }
    
    if let brandName: String = info?.brandName {
      self.brandName.attributedText = NSAttributedString(string: brandName,
                                                         attributes: size.brandName())
    }
    if let name: String = info?.name {
      self.name.attributedText = NSAttributedString(string: name,
                                                    attributes: size.name())
    }
    if let price: String = info?.price {
      self.price.attributedText = NSAttributedString(string: DecimalWon(value: price),
                                                     attributes: size.price())
    }
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [brandName, name, price].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    let verticalInterval: CGFloat = 18
    
    NSLayoutConstraint.activate([
      brandName.topAnchor.constraint(equalTo: topAnchor),
      brandName.leadingAnchor.constraint(equalTo: leadingAnchor),
      brandName.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
      
      name.topAnchor.constraint(equalTo: brandName.topAnchor,
                                constant: verticalInterval),
      name.leadingAnchor.constraint(equalTo: leadingAnchor),
      name.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
      
      price.topAnchor.constraint(equalTo: name.topAnchor,
                                 constant: verticalInterval),
      price.leadingAnchor.constraint(equalTo: leadingAnchor),
      price.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
      price.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  private func DecimalWon(value: String) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    guard let number = Int(value),
          let result = numberFormatter.string(from: NSNumber(value: number))
    else { return "확인이 필요합니다." }
    
    return result + "원"
  }
}

private extension ProductThumbnailSize {
  
  func brandName() -> AttributesOfNSAttributedString {
    let forgroundColor: UIColor = UIColor.monoTertiary
    
    switch self {
    case .large:
      return [ .foregroundColor: forgroundColor,
               .font: UIFont.tertiary ]
    case .medium, .small:
      return [ .foregroundColor: forgroundColor,
               .font: UIFont.quaternary ]
    }
  }
  
  func name() -> AttributesOfNSAttributedString {
    let forgroundColor: UIColor = UIColor.monoPrimary
    
    switch self {
    case .large:
      return [ .foregroundColor: forgroundColor,
               .font: UIFont.tertiary ]
    case .medium, .small:
      return [ .foregroundColor: forgroundColor,
               .font: UIFont.quaternary ]
    }
  }
  
  func price() -> AttributesOfNSAttributedString {
    let forgroundColor: UIColor = UIColor.monoPrimary
    
    switch self {
    case .large:
      return [ .foregroundColor: forgroundColor,
               .font: UIFont.primaryBold ]
    case .medium:
      return [ .foregroundColor: forgroundColor,
               .font: UIFont.secondaryBold ]
    case .small:
      return [ .foregroundColor: forgroundColor,
               .font: UIFont.tertiaryBold ]
    }
  }
}

// TODO:- Model로 옮기기

struct ProductThumbnailInfo {
  let brandName: String?
  let name: String?
  let price: String?
}

enum ProductThumbnailSize {
  case large, medium, small
}
