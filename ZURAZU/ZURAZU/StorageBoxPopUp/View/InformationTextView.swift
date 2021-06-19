//
//  InformationTextView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/20.
//

import UIKit

final class InformationTextView: UITextView {

  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false
  }
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension InformationTextView {
  
  func setupView() {
    font = .quaternaryBold
    textColor = .white
    backgroundColor = .clear
    isScrollEnabled = false
  }
}
