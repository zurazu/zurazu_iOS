//
//  SignInEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import Foundation

enum SignInEndPoint {
  
  case requestSignIn(email: String, password: String)
}

extension SignInEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .requestSignIn:
      guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.signIn.rawValue)
      else { fatalError() }
      
      return url
    }
  }
  
  var query: HTTPQuery? {
    switch self {
    case .requestSignIn(let email, let password):
      return [
        "email": email,
        "password": password
      ]
    }
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
    return nil
  }
}
