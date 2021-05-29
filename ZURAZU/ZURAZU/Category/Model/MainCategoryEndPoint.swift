//
//  MainCategoryEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/27.
//

import Foundation

enum MainCategoryEndPoint {
  
  case requestMainCategories
}

extension MainCategoryEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .requestMainCategories:
      guard let url = URLComponents(string: environmentBaseURL + APICredentials.mainCategories.rawValue)
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
      "Accept": "application/json"
    ]
  }
  
  var bodies: HTTPBody? {
    return nil
  }
}
