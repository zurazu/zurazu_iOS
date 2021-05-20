//
//  CategoryTableViewCell.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell, Reusable {
  
  private let titleLabel: UILabel = .init(frame: .zero)
  private let separator: UIView = .init(frame: .zero)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupCell()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateCell(with categoryType: CategoryType) {
    titleLabel.attributedText = title(withEnglishTitle: categoryType.title,
                                      koreanSubTitle: categoryType.subTitle)
  }
}

private extension CategoryTableViewCell {
  
  func setupCell() {
    separator.backgroundColor = .monoQuinary
    selectionStyle = .none
  }
  
  func setupConstraint() {
    [titleLabel, separator].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
      titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      titleLabel.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor),
      
      separator.widthAnchor.constraint(equalTo: widthAnchor),
      separator.heightAnchor.constraint(equalToConstant: 1),
      separator.centerYAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func title(withEnglishTitle englishTitle: String, koreanSubTitle: String) -> NSMutableAttributedString {
    let title = NSMutableAttributedString(string: englishTitle, attributes: Attributes.categoryBold)
    let subTitle = NSAttributedString(string: koreanSubTitle, attributes: Attributes.category)
    title.append(subTitle)
    
    return title
  }
}
