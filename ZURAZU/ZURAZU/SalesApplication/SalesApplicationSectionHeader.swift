//
//  SalesApplicationSectionHeader.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/29.
//

import UIKit

final class SalesApplicationSectionHeader: UICollectionReusableView {
  
  static var identifier: String {
      return String(describing: Self.self)
  }
  
  var isNecessary: Bool = false {
    didSet {
      necessaryMark.isHidden = !isNecessary
    }
  }
  
  private let titleLabel: UILabel = {
    let label: UILabel = .init()
    
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.textColor = .monoPrimary
    
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label: UILabel = .init()
    
    label.font = .systemFont(ofSize: 12)
    label.textColor = .monoSecondary
    label.numberOfLines = 0
    
    return label
  }()
  
  private let necessaryMark: UILabel = {
    let label: UILabel = .init()
    
    label.font = .systemFont(ofSize: 18, weight: .bold)
    label.text = " *"
    label.textColor = .systemRed
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
}

extension SalesApplicationSectionHeader {
  
  func updateTitleLabelText(_ text: String?) {
    titleLabel.text = text
  }
  
  func updateSubtitleLabelText(_ text: String?) {
    subtitleLabel.text = text
    subtitleLabel.isHidden = (text?.isEmpty) ?? true
  }
}

private extension SalesApplicationSectionHeader {
  
  func configure() {
    let horizontalStackView: UIStackView = .init()
    let verticalStackView: UIStackView = .init()
    
    horizontalStackView.axis = .horizontal
    verticalStackView.axis = .vertical
    
    horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
    necessaryMark.translatesAutoresizingMaskIntoConstraints = false
    verticalStackView.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(verticalStackView)
    verticalStackView.addArrangedSubview(horizontalStackView)
    verticalStackView.addArrangedSubview(subtitleLabel)
    
    let spacer: UIView = .init()
    
    spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    
    horizontalStackView.addArrangedSubview(titleLabel)
    horizontalStackView.addArrangedSubview(necessaryMark)
    horizontalStackView.addArrangedSubview(spacer)
    
    NSLayoutConstraint.activate([trailingAnchor.constraint(greaterThanOrEqualTo: verticalStackView.trailingAnchor),
                                 verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                 verticalStackView.topAnchor.constraint(equalTo: topAnchor),
                                 verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)])

    necessaryMark.isHidden = true
    subtitleLabel.isHidden = true
  }
}

