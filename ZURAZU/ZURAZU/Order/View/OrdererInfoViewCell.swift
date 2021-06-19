//
//  OrdererInfoViewCell.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/20.
//

import UIKit

final class OrdererInfoViewCell: UICollectionViewCell, Reusable {
  
  private let title: UILabel = {
    let label: UILabel = .init()
    label.attributedText = SectionTitle.title(with: "주문자 정보")
    
    return label
  }()
  
  private let subTitle: UILabel = {
    let label: UILabel = .init()
    label.attributedText = NSAttributedString(string: "주문자 정보를 입력하세요.",
                                              attributes: [.foregroundColor: UIColor.monoQuaternary,
                                                           .font: UIFont.tertiary])
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label: UILabel = .init()
    label.attributedText = NSAttributedString(string: "이름",
                                              attributes: [.foregroundColor: UIColor.monoPrimary,
                                                           .font: UIFont.tertiary])
    return label
  }()
  
  private let phoneLabel: UILabel = {
    let label: UILabel = .init()
    label.attributedText = NSAttributedString(string: "휴대폰",
                                              attributes: [.foregroundColor: UIColor.monoPrimary,
                                                           .font: UIFont.tertiary])
    return label
  }()
  
  private let emailLabel: UILabel = {
    let label: UILabel = .init()
    label.attributedText = NSAttributedString(string: "이메일",
                                              attributes: [.foregroundColor: UIColor.monoPrimary,
                                                           .font: UIFont.tertiary])
    return label
  }()
  
  private let nameTextField: UITextField = .init()
  private let phoneTextField: UITextField = .init()
  private let emailTextField: UITextField = .init()
  
  weak var delegate: OrdererInfoViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    [nameTextField, phoneTextField, emailTextField].forEach {
      //      $0.layer.masksToBounds = true
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
      $0.leftView = paddingView
      $0.leftViewMode = .always
      $0.layer.borderColor = UIColor.monoQuinary.cgColor
      $0.layer.borderWidth = 1.0
      $0.delegate = self
    }
    
    phoneTextField.keyboardType = .phonePad
    emailTextField.keyboardType = .emailAddress
  }
  
  private func setupConstraint() {
    translatesAutoresizingMaskIntoConstraints = false
    
    [title, subTitle, nameLabel, phoneLabel, emailLabel, nameTextField, phoneTextField, emailTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    let inset: CGFloat = 16
    
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
      
      title.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -inset),
      title.heightAnchor.constraint(equalToConstant: 20),
      
      subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
      subTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      subTitle.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -inset),
      subTitle.heightAnchor.constraint(equalToConstant: 20),
      
      nameLabel.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: inset),
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      nameLabel.widthAnchor.constraint(equalToConstant: 50),
      
      nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
      nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
      nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      nameTextField.heightAnchor.constraint(equalToConstant: 32),
      
      phoneLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: inset),
      phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      phoneLabel.widthAnchor.constraint(equalToConstant: 50),
      
      phoneTextField.centerYAnchor.constraint(equalTo: phoneLabel.centerYAnchor),
      phoneTextField.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 4),
      phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      phoneTextField.heightAnchor.constraint(equalToConstant: 32),
      
      emailLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: inset),
      emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      emailLabel.widthAnchor.constraint(equalToConstant: 50),
      
      emailTextField.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor),
      emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 4),
      emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      emailTextField.heightAnchor.constraint(equalToConstant: 32),
      emailTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
    ])
  }
}

extension OrdererInfoViewCell: UITextFieldDelegate {
  
//  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//    guard textField == phoneTextField else { return true }
//
//    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//    let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
//
//    let decimalString = components.joined(separator: "") as NSString
//    let length = decimalString.length
//    let hasLeadingOne = length > 0 && decimalString.hasPrefix("1")
//
//    if length == 0 || (length > 11 && !hasLeadingOne) || length > 12 {
//      let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
//
//      return (newLength > 11) ? false : true
//    }
//    var index = 0 as Int
//    let formattedString = NSMutableString()
//
//    if hasLeadingOne {
//      formattedString.append("1 ")
//      index += 1
//    }
//    if (length - index) > 3 {
//      let areaCode = decimalString.substring(with: NSRange(location: index, length: 3))
//      formattedString.appendFormat("%@-", areaCode)
//      index += 3
//    }
//    if length - index > 4 {
//      let prefix = decimalString.substring(with: NSRange(location: index, length: 4))
//      formattedString.appendFormat("%@-", prefix)
//      index += 4
//    }
//
//    let remainder = decimalString.substring(from: index)
//    formattedString.append(remainder)
//    textField.text = formattedString as String
//
//    return false
//  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    if textField == nameTextField {
      phoneTextField.becomeFirstResponder()
    }
    
    if textField == phoneTextField {
      emailTextField.becomeFirstResponder()
    }
    
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == nameTextField {
      delegate?.name = nameTextField.text
      return
    }
    
    if textField == phoneTextField {
      delegate?.phoneNumber = phoneTextField.text
      return
    }
    
    if textField == emailTextField {
      delegate?.email = emailTextField.text
      return
    }
  }
}

protocol OrdererInfoViewDelegate: AnyObject {
  var name: String? { get set }
  var phoneNumber: String? { get set }
  var email: String? { get set }
}
