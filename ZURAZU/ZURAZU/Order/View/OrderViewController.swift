//
//  OrderViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/19.
//

import UIKit
import Combine

final class OrderViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: OrderViewModelType?
  
  private lazy var backButton: UIButton = {
    let button: UIButton = .init(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstrint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBarController?.tabBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    tabBarController?.tabBar.isHidden = false
  }
  
  func bindViewModel() {
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
  }
}

private extension OrderViewController {
  
  func setupView() {
    title = "주문하기"
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  func setupConstrint() {
    
  }
}
