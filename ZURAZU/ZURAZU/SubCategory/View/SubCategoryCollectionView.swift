//
//  SubCategoryCollectionView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/01.
//

import UIKit

final class SubCategoryCollectionView: UICollectionView {
  
  private let selectedLine: UIView = {
    let view: UIView = .init(frame: .zero)
    view.backgroundColor = .bluePrimary
    
    return view
  }()
  
  private lazy var selectedLineWidthConstraint: NSLayoutConstraint = {
    let constraint: NSLayoutConstraint = selectedLine.widthAnchor.constraint(equalToConstant: 0)
    
    return constraint
  }()
  
  private lazy var selectedLineLeadingConstraint: NSLayoutConstraint = {
    let constraint: NSLayoutConstraint = selectedLine.leadingAnchor.constraint(equalTo: leadingAnchor)
    
    return constraint
  }()
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    setupLayout()
    setupView()
    setupContraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func selectItem(at indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionView.ScrollPosition) {
    super.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    guard let indexPath: IndexPath = indexPath else { return }
    
    moveSelectedLine(to: indexPath)
  }
}

private extension SubCategoryCollectionView {
  
  func setupLayout() {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
    
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 25
    flowLayout.estimatedItemSize = CGSize(width: 50, height: 44)
  }
  
  func setupView() {
    alwaysBounceHorizontal = true
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
    register(SubCategoryCollectionViewCell.self)
    backgroundColor = .white
    contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    allowsMultipleSelection = false
  }
  
  func setupContraint() {
    [selectedLine].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      selectedLine.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
      selectedLine.heightAnchor.constraint(equalToConstant: 3),
      selectedLineWidthConstraint,
      selectedLineLeadingConstraint
    ])
  }
  
  func moveSelectedLine(to indexPath: IndexPath) {
    guard let cell: SubCategoryCollectionViewCell = cellForItem(at: indexPath) as? SubCategoryCollectionViewCell else { return }
    
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveEaseInOut) { [weak self] in
      self?.selectedLineWidthConstraint.constant = cell.frame.width
      self?.selectedLineLeadingConstraint.constant = cell.frame.origin.x
      self?.layoutIfNeeded()
    }
  }
}
