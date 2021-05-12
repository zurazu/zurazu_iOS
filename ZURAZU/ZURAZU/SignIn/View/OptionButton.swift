//
//  OptionButton.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/11.
//

import UIKit

// MARK: - 네이밍 변경 필요!
final class OptionButton: UIButton {
  
  convenience init(title: String) {
    self.init(frame: .zero)
    
    setTitle(title, for: .normal)
    setupView()
  }
}

private extension OptionButton {
  func setupView() {
    backgroundColor = .white
    setTitleColor(.black, for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 11)
  }
}
