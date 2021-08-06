//
//  SalesApplicationButton.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/07/13.
//

import UIKit

final class SalesApplicationButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SalesApplicationButton {
  
  func setupView() {
    let image: UIImage? = .init(systemName: "plus.app")
    
    backgroundColor = .bluePrimary
    setImage(image, for: .normal)
    setTitle("판매 신청하기", for: .normal)
    setTitleColor(.white, for: .normal)
    setTitleColor(.monoQuaternary, for: .highlighted)
    titleLabel?.font = .tertiaryBold
    imageView?.contentMode = .scaleAspectFill
    imageView?.tintColor = .white
    contentHorizontalAlignment = .center
    semanticContentAttribute = .forceLeftToRight
    layer.cornerRadius = 5
    
    imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
  }
}
