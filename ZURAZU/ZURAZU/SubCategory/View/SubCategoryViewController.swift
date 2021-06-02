//
//  SubCategoryViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/20.
//

import UIKit
import Combine
import CombineCocoa
import CombineDataSources

final class SubCategoryViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: SubCategoryViewModelType?
  
  private lazy var backButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  private let categoryCollectionView: SubCategoryCollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
    
    self.viewModel?.startFetching.send()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.viewModel?.selectedCategoryIndex.send(IndexPath.first)
  }
  
  func bindViewModel() {
    viewModel?.subCategories
      .receive(on: Scheduler.main)
      .bind(
        subscriber: categoryCollectionView.itemsSubscriber(
          cellIdentifier: "SubCategoryCollectionViewCell",
          cellType: SubCategoryCollectionViewCell.self,
          cellConfig: { cell, _, subCategory in
            cell.updateCell(withSubCategory: subCategory)
          }
        )
      )
      .store(in: &cancellables)
    
    viewModel?.selectedCategoryIndex
      .sink { [weak self] in
        self?.categoryCollectionView.selectCell(at: $0)
      }
      .store(in: &cancellables)
    
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.close.send()
      }
      .store(in: &cancellables)
    
    categoryCollectionView.didSelectItemPublisher
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        self?.viewModel?.selectedCategoryIndex.send($0)
      }
      .store(in: &cancellables)
  }
}

private extension SubCategoryViewController {
  
  func setupView() {
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  func setupConstraint() {
    [categoryCollectionView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      categoryCollectionView.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
