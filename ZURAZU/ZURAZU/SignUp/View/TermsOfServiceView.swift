//
//  TermsOfServiceView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import UIKit
import Combine

final class TermsOfServiceView: UIView {
  
  let checkBoxButton: UIButton = .init(frame: .zero)
  let titleLabel: UILabel = .init(frame: .zero)
  let childStackView: UIStackView = .init(frame: .zero)
  
  weak var superTermsOfServiceView: TermsOfServiceView?
  
  @objc dynamic var isSelected: Bool = false {
    didSet {
      checkBoxButton.isSelected = isSelected
      
      if isSelected == false {
        DispatchQueue.main.async { [unowned self] in
          self.superTermsOfServiceView?.updateCheckBoxButton(for: self.isSelected, withChildView: false)
        }
      }
      
      if let superTermsOfServiceView = superTermsOfServiceView,
         superTermsOfServiceView.isAllSelected {
        superTermsOfServiceView.isSelected = superTermsOfServiceView.isAllSelected
        superTermsOfServiceView.updateCheckBoxButton(for: isSelected, withChildView: false)
      }
    }
  }
  
  var isAllSelected: Bool {
    var result = true
    childStackView.arrangedSubviews.forEach {
      if let subView = $0 as? TermsOfServiceView {
        result = result && subView.isSelected
      }
    }
    
    return result
  }
  
  init(frame: CGRect, title: String, titleSize: TitleSize, necessary: Necessary, childAxis: NSLayoutConstraint.Axis, childViews: [TermsOfServiceView]) {
    super.init(frame: frame)
    
    titleLabel.text = necessary.makeText(with: title)
    titleLabel.font = titleSize.font
    childStackView.axis = childAxis
    childStackView.distribution = .fill
    updateChildStackView(with: childViews)
    
    childViews.forEach {
      $0.superTermsOfServiceView = self
    }
    
    setupView()
    setupConstraint()
  }
  
  init(frame: CGRect, titleSize: TitleSize, necessary: Necessary, title: String) {
    super.init(frame: frame)
    
    titleLabel.text = necessary.makeText(with: title)
    titleLabel.font = titleSize.font
    childStackView.isHidden = true
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension TermsOfServiceView {
  
  func setupView() {
    checkBoxButton.setImage(.unCheck, for: .normal)
    checkBoxButton.addTarget(self, action: #selector(checkBoxButtonTapped), for: .touchUpInside)
  }
  
  func setupConstraint() {
    [checkBoxButton, titleLabel, childStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      checkBoxButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      checkBoxButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      checkBoxButton.widthAnchor.constraint(equalToConstant: 20),
      checkBoxButton.heightAnchor.constraint(equalTo: checkBoxButton.heightAnchor),
      
      titleLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 10),
      titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      titleLabel.centerYAnchor.constraint(equalTo: checkBoxButton.centerYAnchor),
      
      childStackView.topAnchor.constraint(equalTo: checkBoxButton.bottomAnchor, constant: 10),
      childStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      childStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      childStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func updateChildStackView(with childViews: [TermsOfServiceView]) {
    childViews.forEach {
      childStackView.addArrangedSubview($0)
    }
  }
  
  @objc func checkBoxButtonTapped() {
    isSelected = !isSelected
    updateCheckBoxButton(for: checkBoxButton.isSelected)
  }
  
  func updateCheckBoxButton(for isSelected: Bool, withChildView: Bool = true) {
    self.isSelected = isSelected
    checkBoxButton.setImage(isSelected ? .check : .unCheck, for: .normal)
//    superTermsOfServiceView?.updateCheckBoxButton(for: isSelected, withChildView: false)
    if withChildView {
      childStackView.arrangedSubviews.forEach {
        if let subView = $0 as? TermsOfServiceView {
          subView.updateCheckBoxButton(for: isSelected)
        }
      }
    }
  }
}

extension TermsOfServiceView {
  
  enum TitleSize {
    case large
    case normal
    
    var font: UIFont {
      switch self {
      case .large: return .secondaryBold
      case .normal: return .quaternaryBold
      }
    }
  }
  
  enum Necessary {
    case necessary
    case choosable
    case none
    
    func  makeText(with title: String) -> String {
      switch self {
      case .necessary: return "[필수] \(title)"
      case .choosable: return "[선택] \(title)"
      case .none: return "\(title)"
      }
    }
  }
}
