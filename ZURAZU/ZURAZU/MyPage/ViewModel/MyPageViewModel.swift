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
}

final class MyPageViewModel: MyPageViewModelType {
  
  var showSignInScene: PassthroughSubject<Void, Never> = .init()
  
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
  }
}
