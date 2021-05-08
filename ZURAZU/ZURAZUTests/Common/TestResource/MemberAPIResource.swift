//
//  MemberAPIResource.swift
//  ZURAZUTests
//
//  Created by 서명렬 on 2021/05/07.
//

import Foundation
@testable import ZURAZU

struct RegisterResponseData: Decodable { }

struct LoginResponseData: Decodable {
  
  let accessToken: String
  let refreshToken: String
}

struct RefreshTokenResponseData: Decodable {
  
  let accessToken: String
}

enum TestEndPoint {
  
  case register(email: String, password: String)
  case login(email: String, password: String)
  case refreshToken(refreshToken: String)
}

extension TestEndPoint: EndPointable {
  var environmentBaseURL: String {
    return APICredentails.ip.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .register:
      guard let url = URLComponents(string: self.environmentBaseURL + APICredentails.register.rawValue) else { fatalError() }
      return url
    case .login:
      guard let url = URLComponents(string: self.environmentBaseURL + APICredentails.login.rawValue) else { fatalError() }
      return url
    case .refreshToken:
      guard let url = URLComponents(string: self.environmentBaseURL + APICredentails.refreshToken.rawValue) else { fatalError() }
      return url
    }
  }
  
  var query: HTTPQuery? {
    return nil
  }
  
  var httpMethod: HTTPMethod? {
    return .post
  }
  
  var headers: HTTPHeader? {
    return [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
  }
  
  var bodies: HTTPBody? {
    switch self {
    case .register(let email, let password):
      return ["email": email, "password": password]
    case .login(let email, let password):
      return ["email": email, "password": password]
    case .refreshToken(let refreshToken):
      return ["refreshToken": refreshToken]
    }
  }
}
