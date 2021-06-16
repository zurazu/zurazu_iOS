//
//  GradeView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/15.
//

import UIKit

final class GradeView: UIView {

  let gradeLabel: UILabel = .init(frame: .zero)
  let label: UILabel = .init(frame: .zero)
  let pointImageView: UIImageView = .init(frame: .zero)
  let gradeProgressView: GradeProgressView = .init(frame: .zero)
  
  private lazy var rateStackView: UIStackView = {
    let stackView: UIStackView = .init(frame: .zero)
    
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  private let goodRateLabel: RateLabel = .init(frame: .zero, text: "상")
  private let slightlyGoodRateLabel: RateLabel = .init(frame: .zero, text: "중상")
  private let averageRateLabel: RateLabel = .init(frame: .zero, text: "보통")
  private let slightlyBadRateLabel: RateLabel = .init(frame: .zero, text: "중하")
  private let badRateLabel: RateLabel = .init(frame: .zero, text: "하")
  
  private lazy var pointImageViewCenterXConstraint: NSLayoutConstraint = pointImageView.centerXAnchor.constraint(equalTo: gradeProgressView.leadingAnchor)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateView(with productStatus: ProductStatus) {
    processGradeProgress(to: productStatus.rate)
    gradeLabel.text = productStatus.rawValue
    layoutIfNeeded()
    
    pointImageViewCenterXConstraint.constant = gradeProgressView.bounds.width / 4 * productStatus.rate
    
    UIView.animate(withDuration: 0.4) { [weak self] in
      self?.layoutIfNeeded()
    }
  }
}

private extension GradeView {
  
  func setupView() {
    pointImageView.image = UIImage.location
    
    gradeLabel.font = .gradeBold
    gradeLabel.textColor = .bluePrimary
    gradeLabel.textAlignment = .center
    // MARK: - Default로 해놓은 것이기 때문에 삭제해야합니다.
    gradeLabel.text = "A"
    
    label.font = .primaryBold
    label.textColor = .monoPrimary
    label.textAlignment = .center
    label.text = "Grade"
  }
  
  func setupConstraint() {
    [gradeLabel, label, pointImageView, gradeProgressView, rateStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      gradeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      gradeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
      gradeLabel.heightAnchor.constraint(equalTo: gradeLabel.widthAnchor),
      
      label.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor),
      label.centerXAnchor.constraint(equalTo: gradeLabel.centerXAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      
      pointImageView.widthAnchor.constraint(equalToConstant: 28),
      pointImageView.bottomAnchor.constraint(equalTo: gradeProgressView.topAnchor),
      pointImageViewCenterXConstraint,
      
      gradeProgressView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 15),
      gradeProgressView.trailingAnchor.constraint(equalTo: trailingAnchor),
      gradeProgressView.centerYAnchor.constraint(equalTo: gradeLabel.lastBaselineAnchor),
      gradeProgressView.heightAnchor.constraint(equalToConstant: 16),
      
      rateStackView.centerXAnchor.constraint(equalTo: gradeProgressView.centerXAnchor),
      rateStackView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
      rateStackView.widthAnchor.constraint(equalTo: gradeProgressView.widthAnchor, multiplier: 1.25)
    ])
    
    rateStackView.addArrangedSubview(badRateLabel)
    rateStackView.addArrangedSubview(slightlyBadRateLabel)
    rateStackView.addArrangedSubview(averageRateLabel)
    rateStackView.addArrangedSubview(slightlyGoodRateLabel)
    rateStackView.addArrangedSubview(goodRateLabel)
  }
  
  func processGradeProgress(to grade: CGFloat) {
    gradeProgressView.progressAnimation(to: grade / 4)
  }
}

final class RateLabel: UILabel {
  
  init(frame: CGRect, text: String) {
    super.init(frame: frame)
    
    setupView()
    self.text = text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension RateLabel {
  
  func setupView() {
    font = .tertiary
    textColor = .monoTertiary
    textAlignment = .center
  }
}
