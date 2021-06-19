//
//  SalesApplicationCompleteViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/17.
//

import Foundation
import Combine

protocol SalesApplicationCompleteViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class SalesApplicationCompleteViewModel: SalesApplicationCompleteViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension SalesApplicationCompleteViewModel {
  
  func bind() {
    closeEvent
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.goToHome()
      }
      .store(in: &cancellables)
  }
}
