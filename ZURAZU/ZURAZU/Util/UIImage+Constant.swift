//
//  UIImage+Constant.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit

extension UIImage {
  
  static let errorImage = #imageLiteral(resourceName: "errorImage")
  
  static let textAlignLeft: UIImage = UIImage(systemName: "text.alignleft") ?? errorImage
  static let docText      : UIImage = UIImage(systemName: "doc.text")       ?? errorImage
  static let heart        : UIImage = UIImage(systemName: "heart")          ?? errorImage
  static let person       : UIImage = UIImage(systemName: "person")         ?? errorImage
  
  static let docTextFill  : UIImage = UIImage(systemName: "doc.text.fill")  ?? errorImage
  static let heartFill    : UIImage = UIImage(systemName: "heart.fill")     ?? errorImage
  static let personFill   : UIImage = UIImage(systemName: "person.fill")    ?? errorImage
}
