//
//  InspectionStandardViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import Foundation
import Combine

protocol InspectionStandardViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class InspectionStandardViewModel: InspectionStandardViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension InspectionStandardViewModel {
  
  func bind() {
    closeEvent
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.close(animated: true)
      }
      .store(in: &cancellables)
  }
}
