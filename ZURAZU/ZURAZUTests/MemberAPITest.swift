//
//  ZURAZUTests.swift
//  ZURAZUTests
//
//  Created by 서명렬 on 2021/05/06.
//

import XCTest
import Combine
@testable import ZURAZU

class MemberAPITest: XCTestCase {
  // https://1bd46fe6-999a-4dbd-ac76-9cf47f6573af.mock.pstmn.io
  
  private var cancellables: Set<AnyCancellable> = .init()
  
  func test_회원등록() throws {
    let expectation = XCTestExpectation(description: "Register")
    let router: Routable = Router()
    let testEmail = "test"
    let testPassword = "test123"
    
    let testPublisher: AnyPublisher<Result<BaseUser<RegisterResponseData>, NetworkError>, Never> = router.request(route: TestEndPoint.register(email: testEmail, password: testPassword))
    
    testPublisher.sink { _ in
      
    } receiveValue: { result in
      switch result {
      case .success(let data):
        if data.status == "OK", data.message == "DB에 등록 성공" {
          expectation.fulfill()
        }
      case .failure(let error):
        print(error)
      }
    }
    .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 3.0)
  }
  
  
}

struct BaseUser<T: Decodable>: Decodable {
  
  let status: String
  let message: String
  let data: T?
}

struct RegisterResponseData: Decodable { }

enum TestEndPoint {
  
  case register(email: String, password: String)
  case login(email: String, password: String)
  case refreshToken(refreshToken: String)
}

extension TestEndPoint: EndPointable {
  var environmentBaseURL: String {
    return APICredentails.ip.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .register:
      guard let url = URLComponents(string: self.environmentBaseURL + APICredentails.register.rawValue) else { fatalError() }
      return url
    case .login:
      guard let url = URLComponents(string: self.environmentBaseURL + APICredentails.login.rawValue) else { fatalError() }
      return url
    case .refreshToken:
      guard let url = URLComponents(string: self.environmentBaseURL + APICredentails.refreshToken.rawValue) else { fatalError() }
      return url
    }
  }
  
  var query: HTTPQuery? {
    return nil
  }
  
  var httpMethod: HTTPMethod? {
    return .POST
  }
  
  var headers: HTTPHeader? {
    return [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
  }
  
  var bodies: HTTPBody? {
    switch self {
    case .register(let email, let password):
      return ["email": email, "password": password]
    case .login(let email, let password):
      return ["email": email, "password": password]
    case .refreshToken(let refreshToken):
      return ["refreshToken": refreshToken]
    }
  }
}
