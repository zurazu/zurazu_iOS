//
//  SubCategoryEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/30.
//

import Foundation

enum SubCategoryEndPoint {
  
  case subCategories(mainIndex: Int)
  case categoryProducts(offset: Int, limit: Int, mainCategoryIdx: Int, subCategoryIdx: Int?, notOnlySelectProgressing: Bool)
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
    case .categoryProducts:
      guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.categoryProducts.rawValue)
      else { fatalError() }
      
      return url
    }
  }
  
  var query: HTTPQuery? {
    switch self {
    case .subCategories(let mainIndex):
      return ["mainIdx": mainIndex]
      
    case .categoryProducts(let offset, let limit, let mainCategoryIdx, let subCategoryIdx, let notOnlySelectProgressing):
      var query: HTTPQuery = [
        "offset": offset,
        "limit": limit,
        "mainCategoryIdx": mainCategoryIdx,
        "notOnlySelectProgressing": notOnlySelectProgressing
      ]
      
      if let subCategoryIdx = subCategoryIdx {
        query["subCategoryIdx"] = subCategoryIdx
      }
      
      return query
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
