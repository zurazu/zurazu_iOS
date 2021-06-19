//
//  ProductDetailViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/26.
//

import Foundation
import Combine

protocol ProductDetailViewModelType {
  
  var productDeatilIndex: PassthroughSubject<Int, Never> { get }
  var product: PassthroughSubject<Product, Never> { get }
  var inspectionStandardEvent: PassthroughSubject<Void, Never> { get }
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class ProductDetailViewModel: ProductDetailViewModelType {
  
  var productDeatilIndex: PassthroughSubject<Int, Never> = .init()
  var product: PassthroughSubject<Product, Never> = .init()
  var inspectionStandardEvent: PassthroughSubject<Void, Never> = .init()
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension ProductDetailViewModel {
  
  func bind() {
    productDeatilIndex
      .sink { [weak self] in
        self?.requestProductDetail(of: $0)
      }
      .store(in: &cancellables)
    
    inspectionStandardEvent
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.transition(scene: InspectionStandardScene(), using: .push, animated: true)
      }
      .store(in: &cancellables)
    
    closeEvent
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.close(animated: true)
      }
      .store(in: &cancellables)
  }
  
  func requestProductDetail(of productIndex: Int) {
    let networkProvider: NetworkProvider = .init()
    let endPoint = ProductDetailEndPoint.requestProductDetail(productIndex: productIndex)
    
    let productDetailPublisher: AnyPublisher<Result<BaseResponse<ProductDetail>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    productDetailPublisher
      .sink { result in
        switch result {
        case .success(let productDetail):
          // MARK: - 데이터 사용해야함.
//          print(productDetail)
          self.product.send(productDetail.list!.product!)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}
