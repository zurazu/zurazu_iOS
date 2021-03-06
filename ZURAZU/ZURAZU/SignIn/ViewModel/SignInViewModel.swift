//
//  SignInViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import Foundation
import Combine

protocol SignInViewModelType {
  
  var email: CurrentValueSubject<String, Never> { get }
  var password: CurrentValueSubject<String, Never> { get }
  var isValid: PassthroughSubject<Bool, Never> { get }
  var isEmailValid: PassthroughSubject<Bool, Never> { get }
  var isPasswordValid: PassthroughSubject<Bool, Never> { get }
  
  var signUpEvent: PassthroughSubject<Void, Never> { get }
  var signInEvent: PassthroughSubject<Void, Never> { get }
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class SignInViewModel: SignInViewModelType {
  
  var email: CurrentValueSubject<String, Never> = .init("")
  var password: CurrentValueSubject<String, Never> = .init("")
  var isValid: PassthroughSubject<Bool, Never> = .init()
  var isEmailValid: PassthroughSubject<Bool, Never> = .init()
  var isPasswordValid: PassthroughSubject<Bool, Never> = .init()
  
  var signUpEvent: PassthroughSubject<Void, Never> = .init()
  var signInEvent: PassthroughSubject<Void, Never> = .init()
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension SignInViewModel {
  
  func bind() {
    
    email.combineLatest(password)
      .map { Validator.isValid(email: $0) && Validator.isValid(password: $1) }
      .removeDuplicates()
      .sink {
        self.isValid.send($0)
      }
      .store(in: &cancellables)
    
    email
      .sink { self.isEmailValid.send(Validator.isValid(email: $0)) }
      .store(in: &cancellables)
    
    password
      .sink { self.isPasswordValid.send(Validator.isValid(password: $0)) }
      .store(in: &cancellables)
    
    signUpEvent
      .sink {
        SceneCoordinator.shared.transition(scene: SignUpScene(), using: .push, animated: true)
      }
      .store(in: &cancellables)
    
    closeEvent
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.close(animated: true)
      }
      .store(in: &cancellables)
    
    signInEvent
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink {
        self.requestSignIn()
      }
      .store(in: &cancellables)
  }
  
  func requestSignIn() {
    let networkProvider: NetworkProvider = .init()
    
    let endPoint: SignInEndPoint = .requestSignIn(email: email.value, password: password.value)
    
    let requestSignInPublisher: AnyPublisher<Result<BaseResponse<Token>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    requestSignInPublisher
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          guard
            let accessToken: String = responseResult.list?.accessToken.first,
            let refreshToken: String = responseResult.list?.refreshToken.first
          else { return }
          
          Authorization.shared.set(accessToken: accessToken, refreshToken: refreshToken)
          self?.closeEvent.send(())
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}
