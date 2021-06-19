//
//  StorageBoxLocationView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/20.
//

import UIKit

final class StorageBoxLocationView: UIView {
  
  let locationImageView: UIImageView = .init(frame: .zero)
  let titleLabel: UILabel = .init(frame: .zero)
  let locationLabel: UILabel = .init(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.height * 0.4
  }
}

private extension StorageBoxLocationView {
  
  func setupView() {
    backgroundColor = .white
    
    
    titleLabel.text = "📍보관함 위치"
    titleLabel.font = .tertiaryBold
    titleLabel.textColor = .bluePrimary
    
    locationLabel.text = "송포어스 : 서울 강동구 풍성로35길 34 1층"
    locationLabel.font = .quaternaryBold
    locationLabel.textColor = .bluePrimary
  }
  
  func setupConstraint() {
    [locationImageView, titleLabel, locationLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      
      locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
      locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      locationLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0)
    ])
  }
}
