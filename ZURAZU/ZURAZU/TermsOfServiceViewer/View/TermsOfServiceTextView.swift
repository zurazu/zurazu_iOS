//
//  TermsOfServiceTextView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import UIKit

final class TermsOfServiceTextView: UITextView {

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false
  }
}

private extension TermsOfServiceTextView {
  
  func setupView() {
    font = .tertiary
    isEditable = false
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
    contentInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
  }
}
