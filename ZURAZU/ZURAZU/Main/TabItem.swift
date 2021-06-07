//
//  TabFactory.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import UIKit

enum TabItem: Int, CaseIterable {
  case category = 0
  case log
  case search
  case like
  case myPage
  
  var scene: Scene {
    switch self {
    case .category: return CategoryScene()
    case .log: return MainScene()
    case .search: return MainScene()
    case .like: return MainScene()
    case .myPage: return MyPageScene()
    }
  }
  
  var title: String {
    switch self {
    case .category: return "카테고리"
    case .log: return "거래내역"
    case .search: return ""
    case .like: return "좋아요"
    case .myPage: return "마이페이지"
    }
  }
  
  var image: UIImage {
    switch self {
    case .category: return .textAlignLeft
    case .log: return .docText
    case .search: return UIImage()
    case .like: return .heart
    case .myPage: return .person
    }
  }
  
  var selectedImage: UIImage {
    switch self {
    case .category: return .textAlignLeft
    case .log: return .docTextFill
    case .search: return UIImage()
    case .like: return .heartFill
    case .myPage: return .personFill
    }
  }
}
