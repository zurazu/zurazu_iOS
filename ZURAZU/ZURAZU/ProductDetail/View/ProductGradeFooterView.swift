//
//  ProductGradeFooterView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/15.
//

import UIKit

final class ProductGradeFooterView: UICollectionReusableView {
  
  let nameLabel: UILabel = .init(frame: .zero)
  let priceLabel: UILabel = .init(frame: .zero)
  let gradeView: GradeView = .init(frame: .zero)
  let inspectionStandardButton: UIButton = .init(frame: .zero)
  let inspectionStandardLabel: UILabel = .init(frame: .zero)
  
  private var isFirst: Bool = true
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateView(with product: Product) {
    nameLabel.text = product.name
    priceLabel.text = product.price.decimalWon()
    
    if isFirst, let productStatus: ProductStatus = .init(rawValue: product.clothingStatus) {
      gradeView.updateView(with: productStatus)
    }
    
    isFirst = false
  }
}

private extension ProductGradeFooterView {
  
  func setupView() {
    nameLabel.font = .biggest
    nameLabel.textColor = .monoPrimary
    nameLabel.sizeToFit()
    
    priceLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    priceLabel.textColor = .monoPrimary
    
    let attributedString = NSAttributedString(string: "검수 기준",
                                              attributes: [
                                                .underlineStyle: NSUnderlineStyle.single.rawValue,
                                                .underlineColor: UIColor.monoSecondary,
                                                .font: UIFont.systemFont(ofSize: 13)
                                              ])
    inspectionStandardButton.setAttributedTitle(attributedString, for: .normal)
    inspectionStandardButton.setTitleColor(.monoSecondary, for: .normal)
    
    inspectionStandardLabel.font = .quaternary
    inspectionStandardLabel.textColor = .monoTertiary
    inspectionStandardLabel.text = "해당 제품은 안내된 항목에 대해, 주라주의 자체 검수 및 관리를 거쳤음을 알립니다."
    inspectionStandardLabel.numberOfLines = 0
  }
  
  func setupConstraint() {
    [nameLabel, priceLabel, gradeView, inspectionStandardButton, inspectionStandardLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      nameLabel.heightAnchor.constraint(equalToConstant: 24),
      
      priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
      priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      priceLabel.heightAnchor.constraint(equalToConstant: 29),
      
      gradeView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 18),
      gradeView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      gradeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      
      inspectionStandardButton.topAnchor.constraint(equalTo: gradeView.bottomAnchor, constant: 18),
      inspectionStandardButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      inspectionStandardButton.widthAnchor.constraint(equalToConstant: 52),
      
      inspectionStandardLabel.topAnchor.constraint(equalTo: inspectionStandardButton.centerYAnchor, constant: -7),
      inspectionStandardLabel.leadingAnchor.constraint(equalTo: inspectionStandardButton.trailingAnchor, constant: 19),
      inspectionStandardLabel.trailingAnchor.constraint(equalTo: gradeView.trailingAnchor),
      inspectionStandardLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    ])
  }
}
