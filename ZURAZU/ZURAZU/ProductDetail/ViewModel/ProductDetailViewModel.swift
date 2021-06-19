//
//  ProductDetailViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/26.
//

import Foundation
import Combine

protocol ProductDetailViewModelType {
  
  var requestProductDetailData: PassthroughSubject<Void, Never> { get }
  var product: CurrentValueSubject<Product?, Never> { get }
  var zurazuPickProduct: CurrentValueSubject<[CategoryProduct], Never> { get }
  var images: CurrentValueSubject<[ProductImage], Never> { get }
  var inspectionStandardEvent: PassthroughSubject<Void, Never> { get }
  var selectedProduct: PassthroughSubject<Int, Never> { get }
  var closeEvent: PassthroughSubject<Void, Never> { get }
  var orderEvent: PassthroughSubject<Void, Never> { get }
}

final class ProductDetailViewModel: ProductDetailViewModelType {
  
  var requestProductDetailData: PassthroughSubject<Void, Never> = .init()
  var product: CurrentValueSubject<Product?, Never> = .init(nil)
  var zurazuPickProduct: CurrentValueSubject<[CategoryProduct], Never> = .init([])
  var images: CurrentValueSubject<[ProductImage], Never> = .init([])
  var inspectionStandardEvent: PassthroughSubject<Void, Never> = .init()
  var selectedProduct: PassthroughSubject<Int, Never> = .init()
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  var orderEvent: PassthroughSubject<Void, Never> = .init()
  
  private var index: Int
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(index: Int) {
    self.index = index
    bind()
  }
}

private extension ProductDetailViewModel {
  
  func bind() {
    requestProductDetailData
      .sink { [weak self] in
        self?.requestProductDetail()
        self?.requestZurazuPickProductData()
      }
      .store(in: &cancellables)
    
    inspectionStandardEvent
      .debounce(for: 0.05, scheduler: Scheduler.background)
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
    
    orderEvent
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        guard let product = self?.product.value,
              let imageURL = self?.images.value.first?.url
        else { return }
        
        let scene = OrderScene(product: product, imageURL: imageURL)
        SceneCoordinator.shared.transition(scene: scene, using: .push, animated: true)
      }
      .store(in: &cancellables)
    
    selectedProduct
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        guard let productIndex = self?.zurazuPickProduct.value[$0].productIdx else { return }
        SceneCoordinator.shared.transition(scene: ProductDetailScene(index: productIndex), using: .push, animated: true)
      }
      .store(in: &cancellables)
  }
  
  func requestProductDetail() {
    let networkProvider: NetworkProvider = .init()
    let endPoint: ProductDetailEndPoint = .requestProductDetail(productIndex: index)
    
    let productDetailPublisher: AnyPublisher<Result<BaseResponse<ProductDetail>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    productDetailPublisher
      .sink { [weak self] result in
        switch result {
        case .success(let productDetail):
          guard let product = productDetail.list?.product else { return }
          self?.product.send(product)
          self?.images.send(productDetail.list?.images ?? [])

        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
  
  func requestZurazuPickProductData() {
    let networkProvider: NetworkProvider = .init()
    let endPoint: SubCategoryEndPoint = .categoryProducts(offset: 0, limit: 10, mainCategoryIdx: nil, subCategoryIdx: nil, notOnlySelectProgressing: false)
    
    let zurazuPickProductPublisher: AnyPublisher<Result<BaseResponse<CategoryProducts>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    zurazuPickProductPublisher
      .sink { [weak self] result in
        switch result {
        case .success(let data):
          guard let products = data.list?.products else { return }
          
          self?.zurazuPickProduct.send(products)
          
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}
