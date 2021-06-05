//
//  PictureCollectionViewCell.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/30.
//

import Foundation
import UIKit

final class PictureCollectionViewCell: UICollectionViewCell {
  
  let borderView: UIView = {
    let view: UIView = .init()
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.monoSecondary.cgColor
    
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
}

extension PictureCollectionViewCell {
  
}

private extension PictureCollectionViewCell {
  
  func configure() {
    addSubview(borderView)
    
    borderView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                 borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                 borderView.topAnchor.constraint(equalTo: topAnchor),
                                 borderView.bottomAnchor.constraint(equalTo: bottomAnchor)])
  }

}

