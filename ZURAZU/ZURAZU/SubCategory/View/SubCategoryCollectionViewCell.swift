//
//  SubCategoryCollectionViewCell.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/01.
//

import UIKit

final class SubCategoryCollectionViewCell: UICollectionViewCell, Reusable {
  
  private lazy var categoryLabel: UILabel = {
    let label: UILabel = .init(frame: .zero)
    label.textAlignment = .center
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isSelected: Bool {
    didSet {
      isSelected ? updateToSelected() : updateToDeselected()
    }
  }
  
  // MARK: - 해당 AttributedString들을 상수화 해야합니다!
  func updateCell(withSubCategory subCategory: SubCategory) {
    let attributedString: NSAttributedString = .init(string: subCategory.korean, attributes: [
      .foregroundColor : UIColor.monoTertiary,
      .font            : UIFont.secondary
    ])
    categoryLabel.attributedText = attributedString
    animateToSelected()
  }
}

private extension SubCategoryCollectionViewCell {
  
  var categoryLabelText: String {
    return categoryLabel.text ?? ""
  }
  
  func setupConstraint() {
    [categoryLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      categoryLabel.topAnchor.constraint(equalTo: topAnchor),
      categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  // MARK: - 해당 AttributedString들을 상수화 해야합니다!
  func updateToSelected() {
    let attributedString: NSAttributedString = .init(string: categoryLabelText, attributes: [
      .foregroundColor : UIColor.bluePrimary,
      .font            : UIFont.secondaryBold
    ])
    categoryLabel.attributedText = attributedString
  }
  
  func updateToDeselected() {
    let attributedString: NSAttributedString = .init(string: categoryLabelText, attributes: [
      .foregroundColor : UIColor.monoTertiary,
      .font            : UIFont.secondary
    ])
    categoryLabel.attributedText = attributedString
  }
  
  func animateToSelected() {
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .repeat) { [weak self] in
      self?.categoryLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    } completion: { [weak self] _ in
      self?.categoryLabel.transform = .identity
    }
  }
}
