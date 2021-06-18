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
  
  private lazy var backButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  private lazy var collectionView: UICollectionView = {
    typealias SectionFactory = CollectionViewLayoutSectionFactory
    
    let layout: UICollectionViewCompositionalLayout = .init(section: SectionFactory.FullScreenHorizontalImageSection)
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .monoQuinary
    
    collectionView.register(ProductDetailImageViewCell.self)
    collectionView.register(ProductGradeFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ProductGradeFooterView")
    
    return collectionView
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel?.productDeatilIndex.send(4)
  }
  
  func bindViewModel() {
    viewModel?.product
      .subscribe(on: Scheduler.background)
      .receive(on: Scheduler.main)
      .sink { [weak self] in
        print($0)
        // MARK: - 업데이트 해줘야함
      }
      .store(in: &cancellables)
    
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
  }
}

private extension ProductDetailViewController {
  
  func setupView() {
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  func setupConstraint() {
    [collectionView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ProductDetailImageViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    cell.update(image: #imageLiteral(resourceName: "imgKakaofriendsFailure"))
    cell.backgroundColor = .white
    
    return cell
  }
  
//  func numberOfSections(in collectionView: UICollectionView) -> Int {
//    2
//  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionFooter,
       let footerView: ProductGradeFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                                withReuseIdentifier: "ProductGradeFooterView",
                                                                                                for: indexPath) as? ProductGradeFooterView
    else { return ProductGradeFooterView() }
    footerView.backgroundColor = .white
    
    return footerView
  }
  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    viewModel?.detailProductEvent.send(1)
//  }
}
