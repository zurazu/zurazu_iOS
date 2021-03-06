//
//  CategoryViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit
import Combine
import CombineDataSources

final class CategoryViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: CategoryViewModelType?
  
  private var cancellables: Set<AnyCancellable> = []
  
  private lazy var tableView: UITableView = {
    let tableView: UITableView = .init()
    tableView.register(CategoryTableViewCell.self)
    tableView.separatorStyle = .none
    tableView.rowHeight = 59
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
    binding()
    
    viewModel?.startFetching.send()
  }
}

private extension CategoryViewController {
  
  func setupView() {
    title = "카테고리"
  }
  
  func setupConstraint() {
    [tableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  func binding() {
    viewModel?.mainCategories
      .receive(on: Scheduler.main)
      .bind(subscriber: tableView.rowsSubscriber(cellIdentifier: CategoryTableViewCell.defaultReuseIdentifier, cellType: CategoryTableViewCell.self, cellConfig: { cell, _, model in
      cell.updateCell(with: model)
    }))
    .store(in: &cancellables)
    
    tableView.didSelectRowPublisher
      .sink { [weak self] in
        self?.viewModel?.coordinateSubCategory.send($0)
      }
      .store(in: &cancellables)
  }
}
