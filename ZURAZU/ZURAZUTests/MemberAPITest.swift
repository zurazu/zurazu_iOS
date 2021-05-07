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
  
  func test_로그인() throws {
    let expectation = XCTestExpectation(description: "Login")
    let router: Routable = Router()
    let testEmail = "test"
    let testPassword = "test123"
    
    let testPublisher: AnyPublisher<Result<BaseUser<LoginResponseData>, NetworkError>, Never> = router.request(route: TestEndPoint.login(email: testEmail, password: testPassword))
    
    testPublisher.sink { _ in
      
    } receiveValue: { result in
      switch result {
      case .success(let data):
        if data.status == "OK", data.message == "로그인 성공", data.data!.accessToken == "testAccessToken", data.data!.refreshToken == "testRefreshToken" {
          expectation.fulfill()
        }
      case .failure(let error):
        print(error)
      }
    }
    .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 3.0)
  }
  
  func test_accessToken_재발급() {
    let expectation = XCTestExpectation(description: "RefreshToken")
    let router: Routable = Router()
    let refreshToken = "testRefreshToken"
    
    let testPublisher: AnyPublisher<Result<BaseUser<RefreshTokenResponseData>, NetworkError>, Never> = router.request(route: TestEndPoint.refreshToken(refreshToken: refreshToken))
    
    testPublisher.sink { _ in
      
    } receiveValue: { result in
      switch result {
      case .success(let data):
        if data.status == "OK", data.message == "재발급 성공", data.data!.accessToken == "testAccessToken" {
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
