//
//  NSAttributedString+CustomAttribute.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/05/07.
//

import UIKit

enum Attributes {
  
  typealias AttributesOfNSAttributedString = [NSAttributedString.Key: Any]
  
  static let category: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.bluePrimary,
    .font            : UIFont.quaternaryBold
  ]
  
  static let categoryBold: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.biggestBold
  ]
  
  static let brandPrimary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoTertiary,
    .font            : UIFont.smallest
  ]
  
  static let wearPrimary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.tertiary
  ]
  
  static let pricePrimary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.secondary
  ]
  
  static let wearSecondary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.quaternary
  ]
  
  static let priceSecondary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.tertiary
  ]
  
}
