//
//  MyPageViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import UIKit
import Combine
import CombineCocoa

final class MyPageViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: MyPageViewModelType?
  
  // MARK: - 해당 sign in 버튼에 대한 모든 부분은 추후 수정돼야합니다.
  private let signInButton: UIButton = .init(frame: .zero)
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  func bindViewModel() {
    signInButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.showSignInScene.send()
      }
      .store(in: &cancellables)
  }
}

private extension MyPageViewController {
  
  func setupView() {
    signInButton.backgroundColor = .black
  }
  
  func setupConstraint() {
    [signInButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
    ])
  }
}
