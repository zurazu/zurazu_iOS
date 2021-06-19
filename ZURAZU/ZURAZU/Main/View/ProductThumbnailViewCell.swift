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
  private let pickLabel: LabelView = {
    let label: LabelView = .init(frame: .zero)
    label.setup(title: "PICK")
    
    return label
  }()
  
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
    pickLabel.isHidden = size != .medium
  }
  
  func update(image: UIImage?) {
    imageView.image = image
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [imageView, infoView, pickLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    let inset: CGFloat = 16
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
      
      infoView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
      infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
      infoView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -inset),
      infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
      
      pickLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
      pickLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2)
    ])
  }
  
}

final class LabelView: UIView {
  
  private let label: UILabel = .init()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(title: String) {
    label.attributedText = NSAttributedString.init(string: title, attributes: [
      .foregroundColor : UIColor.white,
      .font            : UIFont.quaternaryBold
    ])
    
    backgroundColor = .bluePrimary
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [label].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    let inset: CGFloat = 2
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
    ])
  }
  
}
