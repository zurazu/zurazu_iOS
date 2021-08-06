//
//  NSAttributedString+CustomAttribute.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/05/07.
//

import UIKit

typealias AttributesOfNSAttributedString = [NSAttributedString.Key: Any]

enum Attributes {
  
  static let category: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.bluePrimary,
    .font            : UIFont.tertiaryBold
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
  
  static let placeHolder: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoQuaternary,
    .font            : UIFont.secondary
  ]
  
  static let selectedSubCategory: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.bluePrimary,
    .font            : UIFont.secondaryBold
  ]
  
  static let deselectedSubCategory: AttributesOfNSAttributedString = [
    .foregroundColor : UIColor.monoTertiary,
    .font            : UIFont.secondary
  ]
}
