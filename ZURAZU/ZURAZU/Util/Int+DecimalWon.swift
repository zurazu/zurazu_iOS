//
//  Int+DecimalWon.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import Foundation

extension Int {
  
  func decimalWon() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    guard let result = numberFormatter.string(from: NSNumber(value: self)) else { return " 원" }
    
    return result + "원"
  }
}
