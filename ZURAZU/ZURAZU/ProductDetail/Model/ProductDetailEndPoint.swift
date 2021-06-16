//
//  ProductDetailEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import Foundation

enum ProductDetailEndPoint {
  
  case requestProductDetail(productIndex: Int)
}

extension ProductDetailEndPoint: EndPointable {
 
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .requestProductDetail(let productIndex):
      guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.categoryProducts.rawValue + "/\(productIndex)")
      else { fatalError() }
      
      return url
    }
  }
  
  var query: HTTPQuery? {
    switch self {
    case .requestProductDetail:
      return nil
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
