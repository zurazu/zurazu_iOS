//
//  OrderCompleteViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/17.
//

import Foundation
import Combine

protocol OrderCompleteViewModelType {
  
  var orderCompletedProduct: OrderCompletedProduct { get }
  
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class OrderCompleteViewModel: OrderCompleteViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  var orderCompletedProduct: OrderCompletedProduct
  
  init(orderCompletedProduct: OrderCompletedProduct) {
    self.orderCompletedProduct = orderCompletedProduct
    
    bind()
  }
}

private extension OrderCompleteViewModel {
  
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
