//
//  TokenEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/14.
//

import Foundation

enum TokenEndPoint {
  
  case requestAccessToken
}

extension TokenEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .requestAccessToken:
      guard let url: URLComponents = .init(string: environmentBaseURL + "/member/refreshToken")
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
    return [
      "refreshToken": Authorization.shared.refreshToken ?? "noValue"
    ]
  }
}
