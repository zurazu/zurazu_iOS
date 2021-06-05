//
//  UnderLineTextField.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/28.
//

import UIKit

final class UnderLineTextField: UITextField {
  
  let border = CALayer()
  let inset: CGFloat = 4
  
  // placeholder position
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: inset, dy: inset)
  }
  
  // text position
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: inset, dy: inset)
  }
  
  @IBInspectable var lineColor: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) {
    didSet {
      border.borderColor = lineColor.cgColor
    }
  }
  
  @IBInspectable var lineHeight: CGFloat = CGFloat(1.0) {
    didSet {
      border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight,
                            width: self.frame.size.width, height: self.frame.size.height)
    }
  }
  
  required init?(coder aDecoder: (NSCoder?)) {
    super.init(coder: aDecoder!)
    configure()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    border.frame = CGRect(x: 0, y: frame.size.height - lineHeight,
                          width: self.frame.size.width, height: self.frame.size.height)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    border.frame = CGRect(x: 0, y: frame.size.height - lineHeight,
                          width: self.frame.size.width, height: self.frame.size.height)
  }
}

private extension UnderLineTextField {
  
  func configure() {
    border.borderColor = lineColor.cgColor
    border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight,
                          width: self.frame.size.width, height: self.frame.size.height)
    border.borderWidth = lineHeight
    layer.addSublayer(border)
    layer.masksToBounds = true
  }
}

