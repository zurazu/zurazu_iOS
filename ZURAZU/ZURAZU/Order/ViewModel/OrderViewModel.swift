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
  var orderEvent: PassthroughSubject<Void, Never> { get }
  var product: Product { get }
  var imageURL: String { get }
  var ordererInfo: String? { get set }
}

final class OrderViewModel: OrderViewModelType {
  
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  var orderEvent: PassthroughSubject<Void, Never> = .init()
  var product: Product
  var imageURL: String
  var ordererInfo: String?
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(product: Product, imageURL: String) {
    self.product = product
    self.imageURL = imageURL
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
    
    orderEvent
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        guard let self = self else { return }
        
        let scene = OrderCompleteScene(orderCompletedProduct: .init(orderedUserInformation: self.ordererInfo ?? "", productInformation: "[\(self.product.brand)] \(self.product.name)", price: self.product.price, depositAccountNumber: "주라주 | 국민은행 1234-123453434-1234"))
        SceneCoordinator.shared.transition(scene: scene, using: .push, animated: true)
      }
      .store(in: &cancellables)
  }
}
