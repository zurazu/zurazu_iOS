//
//  OrderProductViewCell.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/16.
//

import UIKit

class OrderProductViewCell: UICollectionViewCell, Reusable {
  
  private let title: UILabel = {
    let label: UILabel = .init()
    label.attributedText = SectionTitle.title(with: "주문 상품")
    
    return label
  }()
  
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
  
  func update(image: UIImage, info: ProductThumbnailInfo) {
    imageView.image = image
    infoView.update(info: info, size: .small)
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [title, imageView, infoView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: contentView.topAnchor),
      title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
      
      imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 21),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 65),
      imageView.heightAnchor.constraint(equalToConstant: 65),
      
      infoView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 21),
      infoView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
      infoView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
      infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
