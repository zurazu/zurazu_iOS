//
//  NibLoadable.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit

protocol NibLoadable {
  
  static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
  
  static var nibName: String {
    return String(describing: self)
  }
}
