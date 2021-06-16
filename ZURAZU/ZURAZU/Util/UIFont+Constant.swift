//
//  UIFont+Constant.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/05/12.
//

import UIKit

enum FontSize {
  
  static let biggest     : CGFloat = 20
  static let primary     : CGFloat = 19
  static let secondary   : CGFloat = 17
  static let tertiary    : CGFloat = 15
  static let quaternary  : CGFloat = 13
  static let smallest    : CGFloat = 12
}

extension UIFont {
  
  static let biggestBold    : UIFont = UIFont.systemFont(ofSize: FontSize.biggest, weight: .bold)
  static let biggest        : UIFont = UIFont.systemFont(ofSize: FontSize.biggest)
  
  static let primaryBold    : UIFont = UIFont.systemFont(ofSize: FontSize.primary, weight: .bold)
  static let primary        : UIFont = UIFont.systemFont(ofSize: FontSize.primary)
  
  static let secondaryBold  : UIFont = UIFont.systemFont(ofSize: FontSize.secondary, weight: .bold)
  static let secondary      : UIFont = UIFont.systemFont(ofSize: FontSize.secondary)
  
  static let tertiaryBold   : UIFont = UIFont.systemFont(ofSize: FontSize.tertiary, weight: .bold)
  static let tertiary       : UIFont = UIFont.systemFont(ofSize: FontSize.tertiary)
  
  static let quaternaryBold : UIFont = UIFont.systemFont(ofSize: FontSize.quaternary, weight: .bold)
  static let quaternary     : UIFont = UIFont.systemFont(ofSize: FontSize.quaternary)
  
  static let smallestBold   : UIFont = UIFont.systemFont(ofSize: FontSize.smallest, weight: .bold)
  static let smallest       : UIFont = UIFont.systemFont(ofSize: FontSize.smallest)
}
