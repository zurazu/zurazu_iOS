//
//  TermsOfServiceViewerViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import UIKit
import Combine

final class TermsOfServiceViewerViewController: UIViewController, ViewModelBindableType {
  
  let textView: TermsOfServiceTextView = .init(frame: .zero)
  private lazy var backButton: UIButton = {
    let button: UIButton = .init(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  var viewModel: TermsOfServiceViewerViewModelType?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
    binding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel?.requestTerms.send(())
    navigationController?.setNavigationBarHidden(false, animated: animated)
    tabBarController?.tabBar.isHidden = true

  }
}

private extension TermsOfServiceViewerViewController {
  
  func setupView() {
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  func setupConstraint() {
    [textView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  func binding() {
    viewModel?.termsOfService
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        self?.title = $0.terms.title
        self?.textView.text = $0.terms.content
      }
      .store(in: &cancellables)
    
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
  }
}
