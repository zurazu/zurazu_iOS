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
    guard let result = numberFormatter.string(from: NSNumber(value: self)) else { return "확인이 필요합니다." }
    
    return result + "원"
  }
}

extension String {
  
  func decimalWon() -> String {
    guard let number = Int(self) else { return "확인이 필요합니다." }
    
    return number.decimalWon()
  }
}
