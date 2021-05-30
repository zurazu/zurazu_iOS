//
//  Routable.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/06.
//

import Foundation
import Combine

enum NetworkError: Error {
  
  case data, decodingJson
  case redirection,
       client,
       server,
       unknown
}

protocol NetworkProvidable {
  
  func request<T>(route: EndPointable) -> AnyPublisher<Result<T, NetworkError>, Never> where T: Decodable
}

extension NetworkProvidable {
  
  func handleNetworkResponseError(_ response: HTTPURLResponse) -> NetworkError? {
    switch response.statusCode {
    case 200...299: return nil
    case 300...399: return .redirection
    case 400...499: return .client
    case 500...599: return .server
    default: return .unknown
    }
  }
  
  func setupRequest(from route: EndPointable) -> URLRequest? {
    var urlComponent: URLComponents = route.baseURL
    
    if let query: HTTPQuery = route.query {
      urlComponent.queryItems = queryItems(from: query)
    }
    
    guard let url: URL = urlComponent.url else { return nil }
    var request: URLRequest = .init(url: url)
    
    if let body: HTTPBody = route.bodies,
       let jsonString: String = jsonString(to: body) {
        request.httpBody = jsonString.data(using: .utf8)
    }
    
    request.httpMethod = route.httpMethod?.value
    route.headers?.forEach { key, value in
      request.setValue("\(value)", forHTTPHeaderField: key)
    }
    
    return request
  }
}

private extension NetworkProvidable {
  
  func queryItems(from query: [String: Any]) -> [URLQueryItem] {
    var queryItems: [URLQueryItem] = .init()
    
    query.forEach { (key, value) in
      let queryItem: URLQueryItem = .init(name: key, value: "\(value)")
      queryItems.append(queryItem)
    }
    
    return queryItems
  }
  
  func jsonString(to body: [String: Any]) -> String? {
    guard
      let data: Data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted),
      let jsonString: String = String(data: data, encoding: .utf8)
    else { return nil }
    
    return jsonString
  }
}
