//
//  ProductThumbnailViewCell.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/01.
//

import UIKit

final class ProductThumbnailViewCell: UICollectionViewCell, Reusable {
  
  private let imageView: UIImageView = {
    let imageView: UIImageView = .init()
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private let infoView: ProductThumbnailInfoView = .init(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(image: UIImage, info: ProductThumbnailInfo, size: ProductThumbnailSize) {
    imageView.image = image
    infoView.update(info: info, size: size)
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [imageView, infoView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
      
      infoView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
      infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      infoView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
      infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
}
