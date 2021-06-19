//
//  OrderViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/19.
//

import Foundation
import Combine

protocol OrderViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class OrderViewModel: OrderViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension OrderViewModel {
  
  func bind() {
    closeEvent
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.close(animated: true)
      }
      .store(in: &cancellables)
  }
}
