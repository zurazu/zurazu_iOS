//
//  MyPageTableViewCell.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/15.
//

import UIKit

final class MyPageTableViewCell: UITableViewCell, Reusable {

  private let logoImageView: UIImageView = .init(frame: .zero)
  private let titleLabel: UILabel = .init(frame: .zero)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateCell(with model: MyPageTableViewModel) {
    logoImageView.image = UIImage(systemName: model.systemImageName)
    titleLabel.text = model.title
  }
}

private extension MyPageTableViewCell {
  
  func setupView() {
    logoImageView.contentMode = .scaleAspectFit
    logoImageView.image = UIImage(systemName: "circle")
    logoImageView.tintColor = .monoTertiary
    
    titleLabel.textAlignment = .center
    titleLabel.attributedText = NSAttributedString(string: "어쩌구 저쩌구", attributes: [
      .foregroundColor: UIColor.monoTertiary,
      .font: UIFont.secondary
    ])
    selectionStyle = .none
  }
  
  func setupConstraint() {
    [logoImageView, titleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      logoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor  ),
      logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
      logoImageView.widthAnchor.constraint(equalToConstant: 27),
      
      titleLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 28),
      titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0)
    ])
  }
}
