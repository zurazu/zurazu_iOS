//
//  CategoryViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import Foundation
import Combine

protocol CategoryViewModelType {
  
  var mainCategories: CurrentValueSubject<[MainCategory], Never> { get }
  var startFetching: PassthroughSubject<Void, Never> { get }
  var coordinateSubCategory: PassthroughSubject<IndexPath, Never> { get }
}

final class CategoryViewModel: CategoryViewModelType {
  
  var mainCategories: CurrentValueSubject<[MainCategory], Never> = .init([])
  var startFetching: PassthroughSubject<Void, Never> = .init()
  var coordinateSubCategory: PassthroughSubject<IndexPath, Never> = .init()
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension CategoryViewModel {
  
  func bind() {
    startFetching.sink { [weak self] in
      self?.fetchMainCategories()
    }
    .store(in: &cancellables)
    
    coordinateSubCategory
      .receive(on: Scheduler.main)
      .sink { [weak self] index in
        guard let selectedCategory = self?.mainCategories.value.first(where: {
          $0.idx == index.row.advanced(by: 1)
        }) else { return }
        
        SceneCoordinator.shared.transition(
          scene: SubCategoryScene(mainCategory: selectedCategory),
          using: .push,
          animated: true
        )
      }
      .store(in: &cancellables)
  }
  
  func fetchMainCategories() {
    // MARK: - Router를 어디서 주입할지 아니면 싱글톤으로 사용할지 논의해야합니다
    let networkProvider: NetworkProvider = .init()
    
    let mainCategoryPublisher: AnyPublisher<Result<BaseResponse<[MainCategory]>, NetworkError>, Never> = networkProvider.request(route: MainCategoryEndPoint.requestMainCategories)
    
    mainCategoryPublisher
      .receive(on: Scheduler.main)
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          guard let mainCategories: [MainCategory] = responseResult.list else { return }
          
          self?.mainCategories.send(mainCategories)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }.store(in: &cancellables)
  }
}
