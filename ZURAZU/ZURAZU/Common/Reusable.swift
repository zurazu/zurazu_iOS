//
//  Reusable.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit

protocol Reusable {
  
  static var defaultReuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
  
  static var defaultReuseIdentifier: String {
    return String(describing: self)
  }
}
