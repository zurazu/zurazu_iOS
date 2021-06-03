//
//  SubCategoryViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/20.
//

import Foundation
import Combine

protocol SubCategoryViewModelType {
  
  var subCategories: PassthroughSubject<[SubCategory], Never> { get }
  var startFetching: PassthroughSubject<Void, Never> { get }
  var close: PassthroughSubject<Void, Never> { get }
}

final class SubCategoryViewModel: SubCategoryViewModelType {
  
  private let mainCategory: MainCategory
  private var cancellables: Set<AnyCancellable> = []
  
  var subCategories: PassthroughSubject<[SubCategory], Never> = .init()
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
  }
}

private extension SubCategoryViewModel {
  
  func fetchSubCategories() {
    let networkProvider: NetworkProvider = .init()
    
    let subCategoryPublisher: AnyPublisher<Result<BaseResponse<SubCategory>, NetworkError>, Never> = networkProvider.request(route: SubCategoryEndPoint.subCategories(mainIndex: mainCategory.idx))
    
    subCategoryPublisher
      .receive(on: Scheduler.main)
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          guard let subCategories: [SubCategory] = responseResult.list else { return }
          
          self?.subCategories.send(subCategories)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
  
  func closeView() {
    SceneCoordinator.shared.close(animated: true)
  }
}
