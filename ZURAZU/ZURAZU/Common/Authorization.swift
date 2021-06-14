//
//  Authorization.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/14.
//

import Foundation
import Combine

final class Authorization {
  
  static let shared: Authorization = .init()
  private let userDefaults: UserDefaults = .standard
  private var cancellables: Set<AnyCancellable> = []
  
  private init() { }
  
  func set(accessToken: String, refreshToken: String) {
    userDefaults.set(accessToken, forKey: "AccessToken")
    userDefaults.set(refreshToken, forKey: "RefreshToken")
    userDefaults.set(true, forKey: "isSignIn")
  }
  
  var accessToken: String? {
    return userDefaults.string(forKey: "AccessToken")
  }
  
  var refreshToken: String? {
    return userDefaults.string(forKey: "RefreshToken")
  }
  
  var isSignedIn: Bool {
    return userDefaults.bool(forKey: "isSignIn")
  }
  
  func requestWithNewAccessToken(completion: @escaping () -> Void) {
    let networkProvider: NetworkProvider = .init()
    let endPoint = TokenEndPoint.requestAccessToken
    
    let tokenPublisher: AnyPublisher<Result<BaseResponse<AccessToken>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    tokenPublisher
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          self?.userDefaults.set(responseResult.list?.accessToken.first, forKey: "AccessToken")
          completion()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}
