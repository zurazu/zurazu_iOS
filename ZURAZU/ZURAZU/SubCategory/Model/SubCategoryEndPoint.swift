//
//  SubCategoryEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/30.
//

import Foundation

enum SubCategoryEndPoint {
  
  case subCategories(mainIndex: Int)
}

extension SubCategoryEndPoint: EndPointable {
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .subCategories:
      guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.subCategories.rawValue)
      else { fatalError() }
      
      return url
    }
  }
  
  var query: HTTPQuery? {
    switch self {
    case .subCategories(let mainIndex):
      return ["mainIdx": mainIndex]
    }
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
