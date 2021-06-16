//
//  MyPageViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import Foundation
import Combine

protocol MyPageViewModelType {
  
  var showSignInScene: PassthroughSubject<Void, Never> { get }
  var isSignedIn: PassthroughSubject<Bool, Never> { get }
  var requestData: PassthroughSubject<Void, Never> { get }
  var profileData: PassthroughSubject<Profile, Never> { get }
  var signOutEvent: PassthroughSubject<Void, Never> { get }
}

final class MyPageViewModel: MyPageViewModelType {
  
  var showSignInScene: PassthroughSubject<Void, Never> = .init()
  var isSignedIn: PassthroughSubject<Bool, Never> = .init()
  var requestData: PassthroughSubject<Void, Never> = .init()
  var profileData: PassthroughSubject<Profile, Never> = .init()
  var signOutEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension MyPageViewModel {
  
  func bind() {
    showSignInScene
      .sink {
        SceneCoordinator.shared.transition(scene: SignInScene(), using: .push, animated: true)
      }
      .store(in: &cancellables)
    
    requestData
      .sink { [weak self] in
        self?.requestProfile()
      }
      .store(in: &cancellables)
    
    signOutEvent
      .sink { [weak self] in
        Authorization.shared.removeUserInformation()
        self?.isSignedIn.send(false)
      }
      .store(in: &cancellables)
  }
  
  func requestProfile() {
    let networkProvider: NetworkProvider = .init()
    let endPoint = MyPageEndPoint.requestProfile
    
    let profilePublisher: AnyPublisher<Result<BaseResponse<MyPageData>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    profilePublisher
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          guard Authorization.shared.accessToken != nil
          else {
            self?.isSignedIn.send(false)
            return
          }
          
          guard
            responseResult.status != "UNAUTHORIZED",
            let profile = responseResult.list?.profile
          else {
            Authorization.shared.requestWithNewAccessToken { [weak self] in
              self?.requestProfile()
            }
            return
          }
          
          self?.profileData.send(profile)
          self?.isSignedIn.send(true)
          
        case .failure(let error):
          print(error.localizedDescription)
          self?.isSignedIn.send(false)
        }
      }
      .store(in: &cancellables)
  }
}
