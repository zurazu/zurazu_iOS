//
//  CategoryType.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import Foundation

enum CategoryType: String, CaseIterable {
  
  case outer
  case top
  case bottom
  case onepiece
  
  var title: String {
    return rawValue.uppercased()
  }
  
  var subTitle: String {
    return divider + korean
  }
  
  private var korean: String {
    switch self {
    case .outer: return "아우터"
    case .top: return "상의"
    case .bottom: return "하의"
    case .onepiece: return "원피스"
    }
  }
  
  private var divider: String {
    return "  ㅣ "
  }
}
