//
//  CategoryTableViewCell.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
  
  private let titleLabel: UILabel = .init(frame: .zero)
  private let subTitleLabel: UILabel = .init(frame: .zero)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension CategoryTableViewCell {
  
  func setupView() {
    
  }
}
