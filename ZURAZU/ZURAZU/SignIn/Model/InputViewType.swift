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
  case confirmPassword
  case name
  
  var title: String {
    switch self {
    case .email: return "이메일 주소 (ID)"
    case .password: return "비밀번호"
    case .confirmPassword: return "비밀번호 확인"
    case .name: return "실명"
    }
  }
  
  var placeHolder: String {
    switch self {
    case .email: return "이메일 입력"
    case .password: return "비밀번호 입력"
    case .confirmPassword: return ""
    case .name: return ""
    }
  }
  
  // MARK: - 사용하지 않지만 혹시나 하는 상황을 위해 남겨 둡니다.
  var emptyMessage: String {
    switch self {
    case .email: return "이메일을 입력해주세요."
    case .password: return "비밀번호를 입력해주세요."
    case .confirmPassword: return "비밀번호를 입력해주세요."
    case .name: return ""
    }
  }
  
  var invalidMessage: String {
    switch self {
    case .email: return "잘못된 이메일 형식입니다."
    case .password: return "영문, 숫자, 특수 기호를 포함해 8-16자리로 입력해주세요."
    case .confirmPassword: return "동일한 비밀번호를 입력해주세요."
    case .name: return ""
    }
  }
  
  var isNecessary: Bool {
    switch self {
    case .email: return true
    case .password: return true
    case .confirmPassword: return true
    case .name: return false
    }
  }
}
