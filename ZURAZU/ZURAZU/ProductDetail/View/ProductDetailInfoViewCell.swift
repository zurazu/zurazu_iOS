//
//  ProductDetailInfoViewCell.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/19.
//

import UIKit

final class ProductDetailInfoViewCell: UICollectionViewCell, Reusable {
  
  let glanceableInfoStackView: GlanceableInfoStackView = .init(frame: .zero)
  let dividerView: UIView = .init(frame: .zero)
  let fullInfoStackView: FullInfoStackView = .init(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(glanceableInfo: GlanceableInfo, fullInfo: FullInfo) {
    glanceableInfoStackView.updateView(with: glanceableInfo)
    fullInfoStackView.updateView(with: fullInfo)
  }
  
  private func setupView() {
    dividerView.backgroundColor = .monoQuinary
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [glanceableInfoStackView, dividerView, fullInfoStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    let inset: CGFloat = 30
    
    NSLayoutConstraint.activate([
      glanceableInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
      glanceableInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
      glanceableInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
      glanceableInfoStackView.heightAnchor.constraint(equalToConstant: 80),
      
      dividerView.topAnchor.constraint(equalTo: glanceableInfoStackView.bottomAnchor, constant: inset),
      dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      dividerView.heightAnchor.constraint(equalToConstant: 2),
      
      fullInfoStackView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: inset),
      fullInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
      fullInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
//      fullInfoStackView.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
  
}
