//
//  ProductDetailViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/26.
//

import UIKit
import Combine

final class ProductDetailViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: ProductDetailViewModelType?
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // 코드 수정해야함.
    viewModel?.productDeatilIndex.send(4)
  }
  
  func bindViewModel() {
    viewModel?.product
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        $0
//        print($0)
        // MARK: - 업데이트 해줘야함
      }
      .store(in: &cancellables)
    
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
  }
}

private extension ProductDetailViewController {
  
  func setupView() {
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  func setupConstraint() {
    
  }
}
