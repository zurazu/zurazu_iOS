//
//  SignUpViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/04.
//

import Foundation
import Combine

protocol SignUpViewModelType {
  
  var email: CurrentValueSubject<String, Never> { get }
  var password: CurrentValueSubject<String, Never> { get }
  var confirmPassword: CurrentValueSubject<String, Never> { get }
  var name: CurrentValueSubject<String, Never> { get }
  var closeEvent: PassthroughSubject<Void, Never> { get }
  
  var isValid: PassthroughSubject<Bool, Never> { get }
  var isEmailValid: PassthroughSubject<Bool, Never> { get }
  var isPasswordValid: PassthroughSubject<Bool, Never> { get }
  var isConfirmPasswordValid: PassthroughSubject<Bool, Never> { get }
  
  var signUpEvent: PassthroughSubject<Void, Never> { get }
}

final class SignUpViewModel: SignUpViewModelType {
  
  var email: CurrentValueSubject<String, Never> = .init("")
  var password: CurrentValueSubject<String, Never> = .init("")
  var confirmPassword: CurrentValueSubject<String, Never> = .init("")
  var name: CurrentValueSubject<String, Never> = .init("")
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  var isValid: PassthroughSubject<Bool, Never> = .init()
  var isEmailValid: PassthroughSubject<Bool, Never> = .init()
  var isPasswordValid: PassthroughSubject<Bool, Never> = .init()
  var isConfirmPasswordValid: PassthroughSubject<Bool, Never> = .init()
  
  var signUpEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
  
}

private extension SignUpViewModel {
  
  func bind() {
    closeEvent
      .sink { SceneCoordinator.shared.close(animated: true) }
      .store(in: &cancellables)
    
    email
      .sink {
        self.isEmailValid.send(Validator.isValid(email: $0))
      }
      .store(in: &cancellables)
    
    password
      .sink {
        self.isPasswordValid.send(Validator.isValid(password: $0))
        
        if !self.confirmPassword.value.isEmpty {
          self.isConfirmPasswordValid.send(self.confirmPassword.value == $0)
        }
      }
      .store(in: &cancellables)
    
    confirmPassword
      .sink {
        self.isConfirmPasswordValid.send(self.password.value == $0)
      }
      .store(in: &cancellables)
    
    isEmailValid.combineLatest(isPasswordValid, isConfirmPasswordValid, name)
      .map { $0 && $1 && $2 && !$3.isEmpty}
      .removeDuplicates()
      .sink {
        self.isValid.send($0)
      }
      .store(in: &cancellables)
    
    signUpEvent
      .sink {
        self.requestSignUp()
      }
      .store(in: &cancellables)
  }
}

private extension SignUpViewModel {
  
  func requestSignUp() {
    let networkProvider: NetworkProvider = .init()
    let endPoint = SignUpEndPoint.signUp(email: email.value, password: password.value, realName: name.value)
    
    let requestSignUpPublisher: AnyPublisher<Result<BaseResponse<NillResponse>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    requestSignUpPublisher
      .sink { [weak self] result in
        switch result {
        case .success(let resultResponse):
          guard resultResponse.status == "OK"
          else { return }
          
          self?.closeEvent.send(())
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}
