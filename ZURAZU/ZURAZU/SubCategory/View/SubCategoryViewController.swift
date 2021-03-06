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
  
  private lazy var productsCollectionView: UICollectionView = {
    typealias SectionFactory = CollectionViewLayoutSectionFactory
    
    let layout: UICollectionViewCompositionalLayout = .init(section: SectionFactory.mainProductSection())
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    
    collectionView.register(ProductThumbnailViewCell.self)
    
    return collectionView
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
    binding()
    
    self.viewModel?.startFetching.send()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.viewModel?.selectedCategoryIndex.send(IndexPath.first)
  }
}

private extension SubCategoryViewController {
  
  func setupView() {
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  func setupConstraint() {
    [categoryCollectionView, productsCollectionView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      categoryCollectionView.heightAnchor.constraint(equalToConstant: 44),
      
      productsCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 10),
      productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      productsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func binding() {
    viewModel?.subCategories
      .receive(on: Scheduler.main)
      .bind(
        subscriber: categoryCollectionView.itemsSubscriber(
          cellIdentifier: SubCategoryCollectionViewCell.defaultReuseIdentifier,
          cellType: SubCategoryCollectionViewCell.self,
          cellConfig: { cell, _, subCategory in
            cell.updateCell(withSubCategory: subCategory)
          }
        )
      )
      .store(in: &cancellables)
    
    viewModel?.selectedCategoryIndex
      .sink { [weak self] in
        self?.categoryCollectionView.selectItem(at: $0, animated: true, scrollPosition: .init())
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
    
    viewModel?.categoryProducts
      .receive(on: Scheduler.main)
      .sink { [weak self] _ in
        self?.productsCollectionView.reloadData()
      }
      .store(in: &cancellables)
  }
}

extension SubCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel?.categoryProducts.value.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ProductThumbnailViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    guard let product = viewModel?.categoryProducts.value[indexPath.row] else { return cell }
    
    let info: ProductThumbnailInfo = .init(
      brandName: product.brand,
      name: product.name,
      price: product.price.decimalWon()
    )
    
    cell.update(info: info, size: .large)
    
    DispatchQueue.global().async {
      ImageService().loadImage(by: product.image.url) { image in
        DispatchQueue.main.async {
          cell.update(image: image)
        }
      }
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.selectedProductIndex.send(indexPath.row)
  }
}
