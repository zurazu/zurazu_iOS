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
  
  private let indexPath: IndexPath
  private var cancellables: Set<AnyCancellable> = []
  
  var subCategories: PassthroughSubject<[SubCategory], Never> = .init()
  var startFetching: PassthroughSubject<Void, Never> = .init()
  var close: PassthroughSubject<Void, Never> = .init()
  
  init(indexPath: IndexPath) {
    self.indexPath = indexPath
    
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
    let network = NetworkProvider()
    
    let subCategoryPublisher: AnyPublisher<Result<BaseResponse<SubCategory>, NetworkError>, Never> = network.request(route: SubCategoryEndPoint.subCategories(mainIndex: indexPath.row))
    
    subCategoryPublisher
      .receive(on: Scheduler.mainScheduler)
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          guard let list = responseResult.list else { return }
          
          self?.subCategories.send(list)
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
