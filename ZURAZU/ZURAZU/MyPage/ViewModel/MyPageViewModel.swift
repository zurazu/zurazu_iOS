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
  
  func requestProfile()
}

final class MyPageViewModel: MyPageViewModelType {
  
  var showSignInScene: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
  
  func requestProfile() {
    let networkProvider: NetworkProvider = .init()
    let endPoint = MyPageEndPoint.requestProfile
    
    let profilePublisher: AnyPublisher<Result<BaseResponse<MyPageData>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    profilePublisher
      .sink { result in
        switch result {
        case .success(let responseResult):
          if responseResult.status == "UNAUTHORIZED" {
            Authorization.shared.requestWithNewAccessToken { [weak self] in
              self?.requestProfile()
            }
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}

private extension MyPageViewModel {
  
  func bind() {
    showSignInScene
      .sink {
        SceneCoordinator.shared.transition(scene: SignInScene(), using: .push, animated: true)
      }
      .store(in: &cancellables)
  }
}
