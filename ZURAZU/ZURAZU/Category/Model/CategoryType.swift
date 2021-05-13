//
//  CategoryType.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import Foundation

enum CategoryType: String, CaseIterable {
  
  case top
  case outer
  case pants
  case onepiece
  case skirt
  case bag
  case shoes
  case headwear
  
  var title: String {
    return rawValue.uppercased()
  }
  
  var subTitle: String {
    return divider + korean
  }
  
  private var korean: String {
    switch self {
    case .top: return "상의"
    case .outer: return "아우터"
    case .pants: return "바지"
    case .onepiece: return "원피스"
    case .skirt: return "스커트"
    case .bag: return "가방"
    case .shoes: return "신발"
    case .headwear: return "모자"
    }
  }
  
  private var divider: String {
    return "  ㅣ "
  }
}
