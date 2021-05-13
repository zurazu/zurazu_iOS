//
//  Array+.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import Foundation

extension Array {
  
  var centerIndex: Int {
    guard !isEmpty else { return 0 }
    
    return count / 2
  }
}
