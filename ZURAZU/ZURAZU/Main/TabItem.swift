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
  case main
  case like
  case myPage
  
  var scene: Scene {
    switch self {
    case .category: return CategoryScene()
    case .log: return UnpreparedScene(title: "거래내역")
    case .main: return MainScene()
    case .like: return UnpreparedScene(title: "좋아요")
    case .myPage: return MyPageScene()
    }
  }
  
  var title: String {
    switch self {
    case .category: return "카테고리"
    case .log: return "거래내역"
    case .main: return ""
    case .like: return "좋아요"
    case .myPage: return "마이페이지"
    }
  }
  
  var image: UIImage {
    switch self {
    case .category: return .textAlignLeft
    case .log: return .docText
    case .main: return UIImage()
    case .like: return .heart
    case .myPage: return .person
    }
  }
  
  var selectedImage: UIImage {
    switch self {
    case .category: return .textAlignLeft
    case .log: return .docTextFill
    case .main: return UIImage()
    case .like: return .heartFill
    case .myPage: return .personFill
    }
  }
}
