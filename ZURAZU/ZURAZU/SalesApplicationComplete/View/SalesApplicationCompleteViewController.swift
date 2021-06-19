//
//  SalesApplicationCompleteViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/17.
//

import UIKit
import Combine

final class SalesApplicationCompleteViewController: CompleteViewController, ViewModelBindableType {
  
  var viewModel: SalesApplicationCompleteViewModelType?
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  func bindViewModel() {
    homeButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send(())
        self?.tabBarController?.tabBar.isHidden = false
      }
      .store(in: &cancellables)
  }
}

private extension SalesApplicationCompleteViewController {
  
  func setupView() {
    title = "판매 신청 완료"
    
    updateGuideText(with: "사진 확인에는 약 1일이 소요됩니다.")
  }
}
