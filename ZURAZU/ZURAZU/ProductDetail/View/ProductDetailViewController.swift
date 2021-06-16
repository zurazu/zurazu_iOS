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
  
  let gradeView: ProductGradeFooterView = .init(frame: .zero)
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  func bindViewModel() {
    viewModel?.product
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        self?.gradeView.updateView(with: $0)
      }
      .store(in: &cancellables)
  }
}

private extension ProductDetailViewController {
  
  func setupView() {
    
  }
  
  func setupConstraint() {
    [gradeView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      gradeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      gradeView.heightAnchor.constraint(equalToConstant: 255),
      gradeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradeView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}
