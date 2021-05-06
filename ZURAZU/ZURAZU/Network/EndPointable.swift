//
//  EndPointable.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/06.
//

import Foundation

typealias HTTPQuery = [String: Any]
typealias HTTPHeader = [String: Any]
typealias HTTPBody = [String: Any]

protocol EndPointable {
  
  var environmentBaseURL: String { get }
  var baseURL: URLComponents { get }
  var query: HTTPQuery? { get }
  var httpMethod: HTTPMethod? { get }
  var headers: HTTPHeader? { get }
  var bodies: HTTPBody? { get }
}

enum HTTPMethod: String {
  
  case GET, POST, PUT, DELETE, PATCH
}

