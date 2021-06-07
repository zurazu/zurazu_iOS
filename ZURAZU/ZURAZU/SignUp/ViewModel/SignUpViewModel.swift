//
//  SignUpViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/04.
//

import Foundation
import Combine

protocol SignUpViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class SignUpViewModel: SignUpViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
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
  }
}
