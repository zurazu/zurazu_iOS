//
//  SignUpEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/10.
//

import Foundation

enum SignUpEndPoint {
  
//  case signUp(email: String, password: String, realName: String, gender: String, birth: Date)
  case signUp(email: String, password: String)
}

extension SignUpEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .signUp:
      guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.signUp.rawValue)
      else { fatalError() }
      
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
//    case .signUp(let email, let password, let realName, let gender, let birth):
//    return [
//      "email": email,
//      "password": password,
//      "realName": realName,
//      "gender": gender,
//      "birth": birth
//    ]
    case .signUp(let email, let password):
      return [
        "email": email,
        "password": password
      ]
    }
  }
  
  
}
