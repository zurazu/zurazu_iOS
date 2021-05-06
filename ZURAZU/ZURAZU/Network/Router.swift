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
  
  func request<T: Decodable>(route: EndPointable) -> AnyPublisher<Result<T, NetworkError>, Never> {
    guard let request = self.setupRequest(from: route) else {
      return .just(.failure(.client))
    }
    
    return self.urlSession.dataTaskPublisher(for: request)
      .mapError { _ in NetworkError.unknown }
      .flatMap { data, response -> AnyPublisher<Data, Error> in
        guard let response = response as? HTTPURLResponse else {
          return .fail(NetworkError.server)
        }
        
        if let error = self.handleNetworkResponseError(response) {
          return .fail(error)
        }
        
        return .just(data)
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .map { .success($0) }
      .catch { _ -> AnyPublisher<Result<T, NetworkError>, Never> in
        return .just(.failure(.decodingJson))
      }
      .eraseToAnyPublisher()
  }
}
