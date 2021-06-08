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
  private let guestGuideView: GuestGuideView = .init(frame: .zero)
  private lazy var logoImageView: UIImageView = {
    let imageView: UIImageView = .init(image: .logoText)
    
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupNavigationBar()
  }
  
  func bindViewModel() {
    guestGuideView.signInButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.showSignInScene.send()
        self?.logoImageView.removeFromSuperview()
      }
      .store(in: &cancellables)
  }
}

private extension MyPageViewController {
  
  func setupView() {
    
  }
  
  func setupConstraint() {
    [guestGuideView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      guestGuideView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      guestGuideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
      guestGuideView.widthAnchor.constraint(equalTo: view.widthAnchor),
    ])
  }
  
  func setupNavigationBar() {
    guard let navigationBar = navigationController?.navigationBar else { return }
    navigationController?.setNavigationBarHidden(false, animated: false)
    
    navigationBar.addSubview(logoImageView)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      logoImageView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16),
      logoImageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
      logoImageView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor, multiplier: 0.3)
    ])
  }
}
