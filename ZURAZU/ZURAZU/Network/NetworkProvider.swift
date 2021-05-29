//
//  Router.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/06.
//

import Foundation
import Combine

final class NetworkProvider: NetworkProvidable {
  
  private let urlSession: URLSession
  
  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  func request<T: Decodable>(route: EndPointable) -> AnyPublisher<Result<T, NetworkError>, Never> {
    guard let request: URLRequest = setupRequest(from: route) else {
      return .just(.failure(.client))
    }
    
    return urlSession.dataTaskPublisher(for: request)
      .mapError { _ in NetworkError.unknown }
      .flatMap { [weak self] data, response -> AnyPublisher<Data, Error> in
        guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
          return .fail(NetworkError.server)
        }
        
        if let error: NetworkError = self?.handleNetworkResponseError(response) {
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
