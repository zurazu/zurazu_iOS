//
//  ProductDetailImageViewCell.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/16.
//

import UIKit

class ProductDetailImageViewCell: UICollectionViewCell, Reusable {
  
  private let imageView: UIImageView = {
    let imageView: UIImageView = .init()
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private let divider: UIView = {
    let divider: UIView = .init()
    divider.backgroundColor = .monoQuinary
    
    return divider
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(image: UIImage) {
    imageView.image = image
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [imageView, divider].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      divider.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      divider.heightAnchor.constraint(equalToConstant: 1),
      divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
