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
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class SignInViewModel: SignInViewModelType {
  
  var email: CurrentValueSubject<String, Never> = .init("")
  var password: CurrentValueSubject<String, Never> = .init("")
  var isValid: PassthroughSubject<Bool, Never> = .init()
  var isEmailValid: PassthroughSubject<Bool, Never> = .init()
  var isPasswordValid: PassthroughSubject<Bool, Never> = .init()
  
  var signUpEvent: PassthroughSubject<Void, Never> = .init()
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
        SceneCoordinator.shared.transition(scene: SignUpScene(), using: .modal, animated: true)
      }
      .store(in: &cancellables)
    
    closeEvent
      .sink {
        SceneCoordinator.shared.close(animated: true)
      }
      .store(in: &cancellables)
  }
}
