//
//  ProfileView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/14.
//

import UIKit

final class ProfileView: UIView {

  lazy var profileImageView: UIImageView = .init(frame: .zero)
  lazy var nameLabel: UILabel = .init(frame: .zero)
  lazy var numberOfTradeProductLabel: UILabel = .init(frame: .zero)
  
  lazy var tableView: UITableView = {
    let tableView: UITableView = .init(frame: .zero)
    
    tableView.rowHeight = 56
    tableView.tableFooterView = UIView()
    tableView.isScrollEnabled = false
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    tableView.separatorInsetReference = .fromCellEdges
    
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateView(with profile: Profile) {
    // MARK: - image 받아올 수 있는 객체를 통해 이미지 넣어줘야함.
    
    if let name = profile.name {
      nameLabel.text = "\(name) 님"
    }
    updateNumberOfTradeProductLabel(with: profile.tradeCount)
  }
}

private extension ProfileView {
  
  func setupView() {
    profileImageView.image = UIImage.baseProfile
    profileImageView.contentMode = .center
    profileImageView.backgroundColor = .monoQuinary
    
    nameLabel.attributedText = NSAttributedString(string: "이름을 설정해주세요.", attributes: Attributes.categoryBold)
    nameLabel.textAlignment = .center
    nameLabel.textColor = .monoPrimary
    
    numberOfTradeProductLabel.textAlignment = .center
    numberOfTradeProductLabel.textColor = .monoPrimary
  }
  
  func setupConstraint() {
    [profileImageView, nameLabel, numberOfTradeProductLabel, tableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
      profileImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
      profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
      profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 26),
      nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
      
      numberOfTradeProductLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      numberOfTradeProductLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      numberOfTradeProductLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
      
      tableView.topAnchor.constraint(equalTo: numberOfTradeProductLabel.bottomAnchor, constant: 45),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func updateNumberOfTradeProductLabel(with count: Int) {
    let firstText = NSMutableAttributedString(string: "총 ", attributes: Attributes.pricePrimary)
    let count = NSAttributedString(string: "\(count)", attributes: Attributes.categoryBold)
    let secondText = NSAttributedString(string: " 벌을 구매하셨습니다.", attributes: Attributes.pricePrimary)
    
    firstText.append(count)
    firstText.append(secondText)
    
    numberOfTradeProductLabel.attributedText = firstText
    
  }
}
