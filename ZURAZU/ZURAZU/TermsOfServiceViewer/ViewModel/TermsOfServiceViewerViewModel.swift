//
//  TermsOfServiceViewerViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import Foundation
import Combine

protocol TermsOfServiceViewerViewModelType {
  
  var requestTerms: PassthroughSubject<Void, Never> { get }
  var termsOfService: PassthroughSubject<TermsOfService, Never> { get }
  var closeEvent: PassthroughSubject<Void, Never> { get }
}

final class TermsOfServiceViewerViewModel: TermsOfServiceViewerViewModelType {
  
  var requestTerms: PassthroughSubject<Void, Never> = .init()
  var termsOfService: PassthroughSubject<TermsOfService, Never> = .init()
  var closeEvent: PassthroughSubject<Void, Never> = .init()
  
  private var termsOfServiceType: TermsOfServiceType
  private var cancellables: Set<AnyCancellable> = []
  
  init(termsOfServiceType: TermsOfServiceType) {
    self.termsOfServiceType = termsOfServiceType
    
    bind()
  }
}

private extension TermsOfServiceViewerViewModel {
  
  func bind() {
    requestTerms
      .sink { [weak self] in
        self?.requestTermsOfService()
      }
      .store(in: &cancellables)
    
    closeEvent
      .receive(on: Scheduler.main)
      .sink {
        SceneCoordinator.shared.close(animated: true)
      }
      .store(in: &cancellables)
  }
  
  func requestTermsOfService() {
    let networkProvider: NetworkProvider = .init()
    let endPoint: TermsOfServiceViewerEndPoint = .requestTermsOfService(termsOfServiceType: termsOfServiceType)
    
    let requestTermsOfServicePublisher: AnyPublisher<Result<BaseResponse<TermsOfService>, NetworkError>, Never> = networkProvider.request(route: endPoint)
    
    requestTermsOfServicePublisher
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          print(responseResult)
          if let termsOfService = responseResult.list {
            self?.termsOfService.send(termsOfService)
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      .store(in: &cancellables)
  }
}
