//
//  UnderLineTextField.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/28.
//

import UIKit

final class UnderLineTextField: UITextField {
  
  let border: CALayer = .init()
  let inset: CGFloat = .init(4)
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: inset, dy: inset)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: inset, dy: inset)
  }
  
  @IBInspectable var lineColor: UIColor = .monoSecondary {
    didSet {
      border.borderColor = lineColor.cgColor
    }
  }
  
  @IBInspectable var lineHeight: CGFloat = .init(1.0) {
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

