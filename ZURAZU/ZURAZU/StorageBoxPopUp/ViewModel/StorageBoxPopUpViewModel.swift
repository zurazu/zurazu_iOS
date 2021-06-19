//
//  StorageBoxPopUpViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/20.
//

import Foundation
import Combine

protocol StorageBoxPopUpViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class StorageBoxPopUpViewModel: StorageBoxPopUpViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension StorageBoxPopUpViewModel {
  
  func bind() {
    closeEvent
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.close(animated: false)
      }
      .store(in: &cancellables)
  }
}
