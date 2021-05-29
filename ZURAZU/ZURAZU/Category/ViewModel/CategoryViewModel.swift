//
//  CategoryViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import Foundation
import Combine

protocol CategoryViewModelType {
  
  var mainCategories: PassthroughSubject<[MainCategory], Never> { get }
  var startFetching: PassthroughSubject<Void, Never> { get }
}

final class CategoryViewModel: CategoryViewModelType {
  
  var mainCategories: PassthroughSubject<[MainCategory], Never> = .init()
  var startFetching: PassthroughSubject<Void, Never> = .init()
  
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
  }
  
  func fetchMainCategories() {
    // MARK: - Router를 어디서 주입할지 아니면 싱글톤으로 사용할지 논의해야합니다
    let router = NetworkProvider()
    
    let testPublisher: AnyPublisher<Result<BaseResponse<MainCategory>, NetworkError>, Never> = router.request(route: MainCategoryEndPoint.requestMainCategories)
    
    testPublisher.sink { result in
      switch result {
      case .success(let responseResult):
        guard let mainCategories = responseResult.list else { return }
        // MARK: - main큐에서 진행할지 커스텀 큐 사용할지 알아보고 수정할 것.
        DispatchQueue.main.sync { [weak self] in
          self?.mainCategories.send(mainCategories)
        }
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }.store(in: &cancellables)
  }
}
