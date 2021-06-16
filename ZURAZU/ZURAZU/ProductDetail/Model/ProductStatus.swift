//
//  ProductStatus.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import Foundation
import CoreGraphics

enum ProductStatus: String {
  
  case good = "A"
  case slightlyGood = "B"
  case average = "C"
  case slightlyBad = "D"
  case bad = "F"
  
  var rate: CGFloat {
    switch self {
    case .good: return 4
    case .slightlyGood: return 3
    case .average: return 2
    case .slightlyBad: return 1
    case .bad: return 0
    }
  }
}

