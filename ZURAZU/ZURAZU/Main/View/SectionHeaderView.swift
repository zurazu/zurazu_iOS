//
//  SectionHeaderView.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/11.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
  private let title: UILabel = .init()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.title.attributedText = SectionTitle.zurazuPick
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(with title: NSAttributedString) {
    DispatchQueue.main.async {
      self.title.attributedText = title
    }
  }
  
  private func setupConstraint() {
    [title].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    let inset: CGFloat = 16
    
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -inset),
      title.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -inset)
    ])
  }
  
}

enum SectionTitle {
  static let zurazuPick: NSAttributedString = {
    let title: NSMutableAttributedString = .init(string: "주라주",
                                                 attributes: [.foregroundColor: UIColor.monoPrimary,
                                                              .font: UIFont.primary])
    let pick: NSAttributedString = .init(string: "PICK",
                                         attributes: [.foregroundColor: UIColor.monoPrimary,
                                                      .font: UIFont.primaryBold])
    title.append(pick)
    
    return title
  }()
  
  static func title(with text: String) -> NSAttributedString {
    .init(string: text,
          attributes: [.foregroundColor: UIColor.monoPrimary,
                       .font: UIFont.primaryBold])
  }
}

class CollectionSeparatorView: UICollectionReusableView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .monoQuinary
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
