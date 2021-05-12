//
//  InputViewType.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import Foundation

enum InputViewType {
  
  case email
  case password
  
  var placeHolder: String {
    switch self {
    case .email: return "이메일 입력"
    case .password: return "비밀번호 입력"
    }
  }
  
  var emptyMessage: String {
    switch self {
    case .email: return "이메일을 입력해주세요."
    case .password: return "비밀번호를 입력해주세요."
    }
  }
  
  var invalidMessage: String {
    switch self {
    case .email: return "잘못된 이메일 형식입니다."
    case .password: return "비밀번호는 8~16자로 입력해주세요."
    }
  }
}
