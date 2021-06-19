//
//  SubCategoryViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/20.
//

import Foundation
import Combine

protocol SubCategoryViewModelType {
  
  var subCategories: CurrentValueSubject<[SubCategory], Never> { get }
  var categoryProducts: CurrentValueSubject<[CategoryProduct], Never> { get }
  var selectedProductIndex: PassthroughSubject<Int, Never> { get }
  var selectedCategoryIndex: PassthroughSubject<IndexPath, Never> { get }
  var startFetching: PassthroughSubject<Void, Never> { get }
  var close: PassthroughSubject<Void, Never> { get }
}

final class SubCategoryViewModel: SubCategoryViewModelType {
  
  private let mainCategory: MainCategory
  private var offset: Int = 0
  private let limit: Int = 20
  private var cancellables: Set<AnyCancellable> = []
  
  var subCategories: CurrentValueSubject<[SubCategory], Never> = .init([])
  var categoryProducts: CurrentValueSubject<[CategoryProduct], Never> = .init([])
  var selectedProductIndex: PassthroughSubject<Int, Never> = .init()
  var selectedCategoryIndex: PassthroughSubject<IndexPath, Never> = .init()
  var startFetching: PassthroughSubject<Void, Never> = .init()
  var close: PassthroughSubject<Void, Never> = .init()
  
  init(mainCategory: MainCategory) {
    self.mainCategory = mainCategory
    
    bind()
  }
  
  func bind() {
    startFetching
      .sink { [weak self] in
        self?.fetchSubCategories()
      }
      .store(in: &cancellables)
    
    close
      .sink { [weak self] in
        self?.closeView()
      }
      .store(in: &cancellables)
    
    selectedCategoryIndex
      .removeDuplicates()
      .map { index -> Int? in
        if index == IndexPath.first {
          return nil
        }
        let selectedCategory = self.subCategories.value[index.row]
        
        return selectedCategory.idx
      }
      .sink { [weak self] in
        self?.offset = 0
        self?.fetchCategoryProducts(at: $0)
      }
      .store(in: &cancellables)
    
    selectedProductIndex
      .sink { [weak self] in
        guard let index = self?.categoryProducts.value[$0].productIdx else { return }
        SceneCoordinator.shared.transition(scene: ProductDetailScene(index: index), using: .push, animated: true)
      }
      .store(in: &cancellables)
  }
}

private extension SubCategoryViewModel {
  
  func fetchSubCategories() {
    let networkProvider: NetworkProvider = .init()
    let subCategoryPublisher: AnyPublisher<Result<BaseResponse<[SubCategory]>, NetworkError>, Never> = networkProvider.request(route: SubCategoryEndPoint.subCategories(mainIndex: mainCategory.idx))
    
    subCategoryPublisher
      .receive(on: Scheduler.main)
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          guard var subCategories: [SubCategory] = responseResult.list,
                let mainCategory = self?.mainCategory
          else { return }
          let category = SubCategory(idx: 0, mainCategory: mainCategory, korean: "전체", english: "all", priority: 0)
          subCategories.insert(category, at: 0)
          
          self?.subCategories.send(subCategories)
          self?.offset = 0
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
  
  // MARK: - 해당 관련 코드는 미완성이므로 수정이 필요합니다!
  func fetchCategoryProducts(at subCategoryIdx: Int?) {
    let networkProvider: NetworkProvider = .init()
    
    let categoryProductsPublisher: AnyPublisher<Result<BaseResponse<CategoryProducts>, NetworkError>, Never> = networkProvider.request(route: SubCategoryEndPoint.categoryProducts(offset: offset, limit: limit, mainCategoryIdx: mainCategory.idx, subCategoryIdx: subCategoryIdx, notOnlySelectProgressing: false))
    
    categoryProductsPublisher
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          guard let data = responseResult.list else { return }
          
          self?.categoryProducts.send(data.products)
          self?.nextOffset()
          
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
  
  func closeView() {
    SceneCoordinator.shared.close(animated: true)
  }
  
  func nextOffset() {
    offset += limit
  }
}
