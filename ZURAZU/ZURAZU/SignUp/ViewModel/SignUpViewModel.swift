//
//  SignUpViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/04.
//

import Foundation
import Combine

protocol SignUpViewModelType {
  
  var isValid: PassthroughSubject<Bool, Never> { get }
  
  var email: CurrentValueSubject<String, Never> { get }
  var password: CurrentValueSubject<String, Never> { get }
  var confirmPassword: CurrentValueSubject<String, Never> { get }
  var name: CurrentValueSubject<String, Never> { get }
  var closeEvent: PassthroughSubject<Void, Never> { get }
  
  var isInputDataValid: PassthroughSubject<Bool, Never> { get }
  
  var isEmailValid: PassthroughSubject<Bool, Never> { get }
  var isPasswordValid: PassthroughSubject<Bool, Never> { get }
  var isConfirmPasswordValid: PassthroughSubject<Bool, Never> { get }
  
  var isTermOfServiceValid: PassthroughSubject<Bool, Never> { get }
  
  var isAgreedZurazuTermOfService: CurrentValueSubject<Bool, Never> { get }
  var isAgreedPersonalInformation: CurrentValueSubject<Bool, Never> { get }
  var isAgreedPushNotification: CurrentValueSubject<Bool, Never> { get }
  var isAgreedReceiveEmail: CurrentValueSubject<Bool, Never> { get }
  var isAgreedReceiveSMS: CurrentValueSubject<Bool, Never> { get }
  var isAgreedReceiveKakaoTalk: CurrentValueSubject<Bool, Never> { get }
  var isAgreedUpperFourteen: CurrentValueSubject<Bool, Never> { get }
  
  var signUpEvent: PassthroughSubject<Void, Never> { get }
  var zurazuTermsOfServiceEvent: PassthroughSubject<Void, Never> { get }
  var termsOfPersonalInformationEvent: PassthroughSubject<Void, Never> { get }
}

final class SignUpViewModel: SignUpViewModelType {

  var email: CurrentValueSubject<String, Never> = .init("")
  var password: CurrentValueSubject<String, Never> = .init("")
  var confirmPassword: CurrentValueSubject<String, Never> = .init("")
  var name: CurrentValueSubject<String, Never> = .init("")
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  var isInputDataValid: PassthroughSubject<Bool, Never> = .init()
  
  var isValid: PassthroughSubject<Bool, Never> = .init()
  var isEmailValid: PassthroughSubject<Bool, Never> = .init()
  var isPasswordValid: PassthroughSubject<Bool, Never> = .init()
  var isConfirmPasswordValid: PassthroughSubject<Bool, Never> = .init()
  
  var isTermOfServiceValid: PassthroughSubject<Bool, Never> = .init()
  
  var isAgreedZurazuTermOfService: CurrentValueSubject<Bool, Never> = .init(false)
  var isAgreedPersonalInformation: CurrentValueSubject<Bool, Never> = .init(false)
  var isAgreedPushNotification: CurrentValueSubject<Bool, Never> = .init(false)
  var isAgreedReceiveEmail: CurrentValueSubject<Bool, Never> = .init(false)
  var isAgreedReceiveSMS: CurrentValueSubject<Bool, Never> = .init(false)
  var isAgreedReceiveKakaoTalk: CurrentValueSubject<Bool, Never> = .init(false)
  var isAgreedUpperFourteen: CurrentValueSubject<Bool, Never> = .init(false)
  
  var signUpEvent: PassthroughSubject<Void, Never> = .init()
  var zurazuTermsOfServiceEvent: PassthroughSubject<Void, Never> = .init()
  var termsOfPersonalInformationEvent: PassthroughSubject<Void, Never> = .init()
  
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
        self.isInputDataValid.send($0)
      }
      .store(in: &cancellables)
    
    signUpEvent
      .sink {
        self.requestSignUp()
      }
      .store(in: &cancellables)
    
    isAgreedZurazuTermOfService.combineLatest(isAgreedPersonalInformation, isAgreedUpperFourteen)
      .map { $0 && $1 && $2 }
      .removeDuplicates()
      .sink {
        self.isTermOfServiceValid.send($0)
      }
      .store(in: &cancellables)
    
    isInputDataValid.combineLatest(isTermOfServiceValid)
      .map { $0 && $1 }
      .removeDuplicates()
      .sink {
        self.isValid.send($0)
      }
      .store(in: &cancellables)
    
    zurazuTermsOfServiceEvent
      .sink {
        SceneCoordinator.shared.transition(scene: TermsOfServiceViewerScene(termsOfServiceType: .accessTerms), using: .push, animated: true)
      }
      .store(in: &cancellables)
    
    termsOfPersonalInformationEvent
      .sink {
        SceneCoordinator.shared.transition(scene: TermsOfServiceViewerScene(termsOfServiceType: .privacyTerms), using: .push, animated: true)
      }
      .store(in: &cancellables)
  }
}

private extension SignUpViewModel {
  
  func requestSignUp() {
    let networkProvider: NetworkProvider = .init()
    let endPoint = SignUpEndPoint.signUp(userSignUpInformation: makeUserSignUpInformation())
    
    let requestSignUpPublisher: AnyPublisher<Result<BaseResponse<NillResponse>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    requestSignUpPublisher
      .receive(on: Scheduler.main)
      .sink { [weak self] result in
        switch result {
        case .success(let resultResponse):
          guard resultResponse.status == "OK"
          else { return }
          
          self?.closeEvent.send()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
  
  func makeUserSignUpInformation() -> UserSignUpInformation {
    let userSignupInformation: UserSignUpInformation = .init(
      email: email.value,
      password: password.value,
      realName: name.value,
      agreeTermsOfService: isAgreedZurazuTermOfService.value,
      agreeCollectionPersonalInfo: isAgreedPersonalInformation.value,
      agreePushNotification: isAgreedPushNotification.value,
      agreeReceiveEmail: isAgreedReceiveEmail.value,
      agreeReceiveSMS: isAgreedReceiveSMS.value,
      agreeReceiveKAKAO: isAgreedReceiveKakaoTalk.value,
      agreeUpperFourteen: isAgreedUpperFourteen.value
    )
    
    return userSignupInformation
  }
}
