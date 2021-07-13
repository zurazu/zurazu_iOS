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
  
  private let tableViewData: [MyPageTableViewModel] = [
    UpdateProfileModel(),
    SearchOrderModel(),
    SearchSellModel(),
    SignOutModel()
  ]
  
  private let guestGuideView: GuestGuideView = .init(frame: .zero)
  private let profileView: ProfileView = .init(frame: .zero)
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
    binding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupNavigationBar()
    
    viewModel?.requestData.send()
  }
}

private extension MyPageViewController {
  
  func setupView() {
    profileView.isHidden = true
    guestGuideView.isHidden = true
    
    profileView.tableView.register(MyPageTableViewCell.self)
    profileView.tableView.dataSource = self
  }
  
  func setupConstraint() {
    [guestGuideView, profileView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      guestGuideView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      guestGuideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
      guestGuideView.widthAnchor.constraint(equalTo: view.widthAnchor),
      
      profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func binding() {
    guestGuideView.signInButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.showSignInScene.send()
        self?.logoImageView.removeFromSuperview()
      }
      .store(in: &cancellables)
    
    viewModel?.isSignedIn
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        if $0 {
          self?.guestGuideView.isHidden = true
          self?.profileView.isHidden = false
        } else {
          self?.profileView.isHidden = true
          self?.guestGuideView.isHidden = false
        }
      }
      .store(in: &cancellables)
    
    profileView.tableView
      .didSelectRowPublisher
      .sink { [weak self] in
        if $0.row == 3 {
          self?.viewModel?.signOutEvent.send()
        }
      }
      .store(in: &cancellables)
    
    viewModel?.profileData
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        self?.profileView.updateView(with: $0)
      }
      .store(in: &cancellables)
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

extension MyPageViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tableViewData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: MyPageTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    
    cell.updateCell(with: tableViewData[indexPath.row])
    
    return cell
  }
}
