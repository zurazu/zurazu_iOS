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
  var requestProductsData: PassthroughSubject<Void, Never> { get }
  var products: CurrentValueSubject<[CategoryProduct], Never> { get }
}

final class MainViewModel: MainViewModelType {
  
  var detailProductEvent: PassthroughSubject<Int, Never> = .init()
  var salesApplicationEvent: PassthroughSubject<Void, Never> = .init()
  var requestProductsData: PassthroughSubject<Void, Never> = .init()
  
  var products: CurrentValueSubject<[CategoryProduct], Never> = .init([])
  
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
      .sink { [weak self] in
        guard let index = self?.products.value[$0].productIdx else { return }
        SceneCoordinator.shared.transition(scene: ProductDetailScene(index: index), using: .push, animated: true)
      }
      .store(in: &cancellables)
    
    salesApplicationEvent
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.transition(scene: SalesApplicationScene(), using: .push, animated: true)
      }
      .store(in: &cancellables)
    
    requestProductsData
      .sink { [weak self] in
        self?.requestProducts()
      }
      .store(in: &cancellables)
  }
  
  func requestProducts() {
    let networkProvider: NetworkProvider = .init()
    // MARK: - offset과 limit 계산해야함. subcategory화면에서도 마찬가지임.
    let endPoint: SubCategoryEndPoint = .categoryProducts(offset: 0, limit: 10, mainCategoryIdx: nil, subCategoryIdx: nil, notOnlySelectProgressing: false)
    
    let productsPublisher: AnyPublisher<Result<BaseResponse<CategoryProducts>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    productsPublisher
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          guard let list = responseResult.list else { return }
          self?.products.send(list.products)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}
