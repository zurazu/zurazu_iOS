//
//  SignUpPickerLabel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/10.
//

import UIKit

final class SignUpPickerLabel: UILabel {
  
  private let topInset: CGFloat = 3
  private let bottomInset: CGFloat = 3
  private let leftInset: CGFloat = 10
  private let rightInset: CGFloat = 10
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
  }
  
  override var intrinsicContentSize: CGSize {
    get {
      var contentSize = super.intrinsicContentSize
      contentSize.height += topInset + bottomInset
      contentSize.width += leftInset + rightInset
      return contentSize
    }
  }
  
  func updateText(with text: String) {
    self.text = text
  }
}

private extension SignUpPickerLabel {
  
  func setupView() {
    layer.borderColor = UIColor.monoSecondary.cgColor
    layer.borderWidth = 0.5
    
    attributedText = NSAttributedString(string: "선택해주세요.", attributes: Attributes.placeHolder)
  }
}
