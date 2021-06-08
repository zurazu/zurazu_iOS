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
  private let notSignInView: NotSignInView = .init(frame: .zero)
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
    signInButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.showSignInScene.send()
        self?.logoImageView.removeFromSuperview()
      }
      .store(in: &cancellables)
  }
}

private extension MyPageViewController {
  
  func setupView() {
    signInButton.backgroundColor = .bluePrimary
    signInButton.titleLabel?.font = .primaryBold
    signInButton.setTitle("로그인 하기", for: .normal)
    signInButton.setTitleColor(.background, for: .normal)
    
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  func setupConstraint() {
    [signInButton, notSignInView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      notSignInView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      notSignInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      notSignInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      notSignInView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
      notSignInView.widthAnchor.constraint(equalTo: view.widthAnchor),
      
      signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signInButton.topAnchor.constraint(equalTo: notSignInView.bottomAnchor),
      signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      signInButton.heightAnchor.constraint(equalToConstant: 53)
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
