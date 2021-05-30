//
//  CategoryDetailViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/20.
//

import UIKit
import Combine
import CombineCocoa
import CombineDataSources

final class CategoryDetailViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: CategoryDetailViewModelType?
  
  private lazy var backButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  func bindViewModel() {
    viewModel?.subCategories
      .receive(on: Scheduler.mainScheduler)
      .sink(receiveValue: { subCategories in
        print(subCategories)
      })
      .store(in: &cancellables)
    
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.close.send()
      }
      .store(in: &cancellables)
    
    // MARK: - Test Code입니다. 추후 삭제 예정입니다.
    navigationItem.leftBarButtonItem?.tapPublisher
      .sink {
        
      }
      .store(in: &cancellables)

    self.viewModel?.startFetching.send()
  }
}

private extension CategoryDetailViewController {
  
  func setupView() {
    let leftButtonItem = UIBarButtonItem(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  func setupConstraint() {
    
  }
}
