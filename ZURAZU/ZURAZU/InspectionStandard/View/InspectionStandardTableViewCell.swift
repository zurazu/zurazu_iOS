//
//  InspectionStandardTableViewCell.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import UIKit

final class InspectionStandardTableViewCell: UITableViewCell, Reusable {
  
  let titleLabel: UILabel = .init(frame: .zero)
  let standardStackView: UIStackView = .init(frame: .zero)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    titleLabel.text = .none
    standardStackView.removeAllArrangedSubviews()
  }
  
  func updateCell(with model: InspectionStandardModel) {
    titleLabel.text = model.title
    setupStackView(with: model.standards)
  }
}

private extension InspectionStandardTableViewCell {
  
  func setupView() {
    selectionStyle = .none
    
    titleLabel.font = .primaryBold
    titleLabel.textColor = .monoPrimary
    
    standardStackView.axis = .vertical
    standardStackView.spacing = 5
    standardStackView.distribution = .fillEqually
  }
  
  func setupConstraint() {
    [titleLabel, standardStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
      titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
      
      standardStackView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      standardStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      standardStackView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
      standardStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23)
    ])
  }
  
  func setupStackView(with standards: [String]) {
    standards.forEach {
      let standardLabel: UILabel = .init(frame: .zero)
      
      standardLabel.text = $0
      standardLabel.font = .tertiary
      standardLabel.textColor = .monoSecondary
      
      standardStackView.addArrangedSubview(standardLabel)
    }
  }
}
