//
//  MainViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/07.
//

import Foundation
import Combine

protocol MainViewModelType {
  
  var detailProductEvent: PassthroughSubject<Int, Never> { get }
  var salesApplicationEvent: PassthroughSubject<Void, Never> { get }
}

final class MainViewModel: MainViewModelType {
  
  var detailProductEvent: PassthroughSubject<Int, Never> = .init()
  var salesApplicationEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension MainViewModel {
  
  func bind() {
    detailProductEvent
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink { productIndex in
        SceneCoordinator.shared.transition(scene: ProductDetailScene(), using: .push, animated: true)
      }
      .store(in: &cancellables)
    
    salesApplicationEvent
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.transition(scene: SalesApplicationScene(), using: .push, animated: true)
      }
      .store(in: &cancellables)
  }
  
  func requestProducts() {
    
  }
}
