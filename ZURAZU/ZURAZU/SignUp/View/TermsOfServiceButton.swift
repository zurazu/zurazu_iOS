//
//  TermsOfServiceButton.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import UIKit

final class TermsOfServiceButton: UIButton {

  init(frame: CGRect, title: String) {
    super.init(frame: frame)
    
    setTitle(title, for: .normal)
    setupButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension TermsOfServiceButton {
  
  func setupButton() {
    guard let title = title(for: .normal) else { return }
    let attributedString: NSMutableAttributedString = .init(string: title)
    attributedString.addAttribute(.underlineStyle, value: 1, range: .init(location: 0, length: title.count))
    attributedString.addAttribute(.foregroundColor, value: UIColor.monoTertiary, range: .init(location: 0, length: title.count))
    attributedString.addAttribute(.font, value: UIFont.tertiaryBold, range: .init(location: 0, length: title.count))
    
    setAttributedTitle(attributedString, for: .normal)
  }
}
