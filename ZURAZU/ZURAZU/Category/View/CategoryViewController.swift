//
//  CategoryViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit

final class CategoryViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: CategoryViewModelType?
  
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
    tableView.dataSource = self
  }
  
  func bindViewModel() {
    
  }
}

private extension CategoryViewController {
  
  func setupView() {
    title = "카테고리"
  }
  
  func setupConstraint() {
    [tableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(tableView)
    }
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}

extension CategoryViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let viewModel: CategoryViewModelType = viewModel else { return 0 }
    
    return viewModel.categoryTypes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CategoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    
    if let viewModel: CategoryViewModelType = viewModel {
      cell.updateCell(with: viewModel.categoryTypes[indexPath.row])
    }
    
    return cell
  }
}
