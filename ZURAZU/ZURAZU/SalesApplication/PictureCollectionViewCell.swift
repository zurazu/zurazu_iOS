//
//  PictureCollectionViewCell.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/30.
//

import Foundation
import UIKit
import Combine

protocol PictureCollectionViewCellDelegate: AnyObject {
  
  func tapImageView(_ cell: PictureCollectionViewCell)
}

final class PictureCollectionViewCell: UICollectionViewCell {
  
  var cancellables: Set<AnyCancellable> = []
  weak var delegate: PictureCollectionViewCellDelegate?
  
  let borderImageView: UIImageView = {
    let view: UIImageView = .init()
    
    view.layer.borderWidth = 1
    view.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    
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
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cancellables = []
  }
}

extension PictureCollectionViewCell {
  
}

private extension PictureCollectionViewCell {
  
  func configure() {
    addSubview(borderImageView)
    
    borderImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([borderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                 borderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                 borderImageView.topAnchor.constraint(equalTo: topAnchor),
                                 borderImageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    
    borderImageView.isUserInteractionEnabled = true
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView(sender:)))
    
    borderImageView.addGestureRecognizer(tapGesture)
  }
  
  @objc func tapImageView(sender: UITapGestureRecognizer) {
    delegate?.tapImageView(self)
  }
  
}


