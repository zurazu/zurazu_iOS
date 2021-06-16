//
//  UIStackView+.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import UIKit

extension UIStackView {
  
  func removeAllArrangedSubviews() {
    self.arrangedSubviews.forEach {
      removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
  }
}

