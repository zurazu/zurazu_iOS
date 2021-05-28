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
  var fetchMainCategories: PassthroughSubject<Void, Never> { get }
}

final class CategoryViewModel: CategoryViewModelType {
  
  private let sceneCoordinator: SceneCoordinatorType
  private var cancellables: Set<AnyCancellable> = []
  
  var mainCategories: PassthroughSubject<[MainCategory], Never> = .init()
  var fetchMainCategories: PassthroughSubject<Void, Never> = .init()
  
  init(sceneCoordinator: SceneCoordinatorType) {
    self.sceneCoordinator = sceneCoordinator
    
    bind()
  }
}

private extension CategoryViewModel {
  
  func bind() {
    fetchMainCategories.sink { [weak self] in
      self?.requestMainCategories()
    }
    .store(in: &cancellables)
  }
  
  func requestMainCategories() {
    // MARK: - Router를 어디서 주입할지 아니면 싱글톤으로 사용할지 논의해야합니다
    let router = Router()
    
    let testPublisher: AnyPublisher<Result<BaseResponse<MainCategory>, NetworkError>, Never> = router.request(route: MainCategoryEndPoint.requestMainCategories)
    
    testPublisher.sink { result in
      switch result {
      case .success(let responseResult):
        guard let mainCategories = responseResult.list else { return }
        // MARK: - main큐에서 진행할지 커스텀 큐 사용할지 알아보고 수정할 것.
        DispatchQueue.main.sync {
          self.mainCategories.send(mainCategories)
        }
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }.store(in: &cancellables)
  }
}
