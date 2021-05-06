//
//  Router.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/06.
//

import Foundation
import Combine

final class Router: Routable {
  
  private let urlSession: URLSession
  
  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  func request<T>(route: EndPointable) -> AnyPublisher<T, NetworkError> where T : Decodable {
    guard let request = self.setupRequest(from: route) else {
      let result: AnyPublisher<T, NetworkError> = AnyPublisher<T, NetworkError>.init(Result<T, NetworkError>.Publisher(.client))
      return result
    }
    
    return self.urlSession.dataTaskPublisher(for: request)
      .tryMap { data, response -> T in
        guard let response = response as? HTTPURLResponse else {
          throw NetworkError.client
        }
        
        guard
          let responseError = self.handleNetworkResponseError(response)
        else {
          do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
          } catch {
            throw NetworkError.decodingJson
          }
        }
        
        throw responseError
      }
      .mapError { error -> NetworkError in
        return .unknown
      }
      .eraseToAnyPublisher()
  }
}
