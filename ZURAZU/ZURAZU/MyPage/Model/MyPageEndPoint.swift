//
//  MyPageEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import Foundation

enum MyPageEndPoint {
  
  case requestProfile
}

extension MyPageEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .requestProfile:
      guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.profile.rawValue)
      else { fatalError() }
      
      return url
    }
  }
  
  var query: HTTPQuery? {
    return nil
  }
  
  var httpMethod: HTTPMethod? {
    return .get
  }
  
  var headers: HTTPHeader? {
    return [
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authentication": Authorization.shared.accessToken ?? ""
    ]
  }
  
  var bodies: HTTPBody? {
    return nil
  }
}
