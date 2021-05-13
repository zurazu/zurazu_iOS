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
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.primary,
    .paragraphStyle  : NSTextAlignment.left
  ]
  
  static let categoryBold: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoQuaternary,
    .font            : UIFont.primary,
    .paragraphStyle  : NSTextAlignment.left
  ]
  
  static let brandPrimary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoTertiary,
    .font            : UIFont.smallest,
    .paragraphStyle  : NSTextAlignment.left
  ]
  
  static let wearPrimary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.tertiary,
    .paragraphStyle  : NSTextAlignment.left
  ]
  
  static let pricePrimary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.secondary,
    .paragraphStyle  : NSTextAlignment.left
  ]
  
  static let wearSecondary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.quaternary,
    .paragraphStyle  : NSTextAlignment.left
  ]
  
  static let priceSecondary: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoPrimary,
    .font            : UIFont.tertiary,
    .paragraphStyle  : NSTextAlignment.left
  ]
  
}
