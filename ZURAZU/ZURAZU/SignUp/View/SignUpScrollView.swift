//
//  SignUpScrollView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/11.
//

import UIKit

final class SignUpScrollView: UIScrollView {

  private var lastContentOffset: CGPoint = .zero
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    endEditing(true)
  }
  
  func setLastContentOffset() {
    setContentOffset(lastContentOffset, animated: true)
  }
}

private extension SignUpScrollView {
  
  func setupView() {
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
    contentInset = UIEdgeInsets(top: 36, left: 0, bottom: 36, right: 0)
    alwaysBounceVertical = true
  }
}

extension SignUpScrollView: InputViewDelegate {
  
  func inputViewEditingDidBegin(_ inputView: InputView, superviewFrame: CGRect?) {
    guard let superviewFrame: CGRect = superviewFrame else { return }
    lastContentOffset = contentOffset
    setContentOffset(CGPoint(x: superviewFrame.origin.x, y: superviewFrame.origin.y - 50), animated: true)
  }
}
