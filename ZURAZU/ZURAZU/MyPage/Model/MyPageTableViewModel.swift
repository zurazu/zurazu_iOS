//
//  MyPageTableViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/15.
//

import Foundation

protocol MyPageTableViewModel {
  
  var systemImageName: String { get }
  var title: String { get }
  var scene: Scene? { get }
}

struct UpdateProfileModel: MyPageTableViewModel {
  
  var systemImageName: String = "person"
  var title: String = "내 프로필 수정하기"
  var scene: Scene? = nil
}

struct SearchOrderModel: MyPageTableViewModel {
  
  var systemImageName: String = "doc.text"
  var title: String = "주문 조회"
  var scene: Scene? = nil
}

struct SearchSellModel: MyPageTableViewModel {
  
  var systemImageName: String = "doc.text"
  var title: String = "판매 조회"
  var scene: Scene? = nil
}

struct SignOutModel: MyPageTableViewModel {
  
  var systemImageName: String = "arrow.right.circle"
  var title: String = "로그아웃"
  var scene: Scene? = nil
}
