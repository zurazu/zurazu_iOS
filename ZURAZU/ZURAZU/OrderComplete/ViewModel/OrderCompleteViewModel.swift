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
  var storageBoxPopUpEvent: PassthroughSubject<Void, Never> { get }
  
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class OrderCompleteViewModel: OrderCompleteViewModelType {
  
  var storageBoxPopUpEvent: PassthroughSubject<Void, Never> = .init()
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
    
    storageBoxPopUpEvent
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.transition(scene: StorageBoxPopUpScene(), using: .present, animated: false)
      }
      .store(in: &cancellables)
  }
}
