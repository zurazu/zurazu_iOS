//
//  SalesApplicationViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/21.
//

import Foundation
import Combine

protocol SalesApplicationViewModelType {
  
  var subCategories: CurrentValueSubject<[SubCategory], Never> { get }
  var startEvent: PassthroughSubject<Void, Never> { get }
}

final class SalesApplicationViewModel: SalesApplicationViewModelType {
  
  var subCategories: CurrentValueSubject<[SubCategory], Never> = .init([])
  var startEvent: PassthroughSubject<Void, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension SalesApplicationViewModel {
  
  func bind() {
    startEvent
      .sink { [weak self] in
        self?.requestSubCategories()
      }
      .store(in: &cancellables)
  }
  
  func requestSubCategories() {
    let networkProvider: NetworkProvider = .init()
    let endPoint = SubCategoryEndPoint.subCategories(mainIndex: nil)
    
    let subCategoriesPublisher: AnyPublisher<Result<BaseResponse<[SubCategory]>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    subCategoriesPublisher
      .sink { result in
        switch result {
        case .success(let responseResult):
          guard let subCateogries = responseResult.list else { return }
          self.subCategories.send(subCateogries)
          
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}

