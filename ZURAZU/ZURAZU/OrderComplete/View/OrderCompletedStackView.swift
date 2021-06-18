//
//  OrderCompletedStackView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import UIKit

final class OrderCompletedStackView: UIStackView {

  let orderedUserInformationView: OrderCompletedView = .init(frame: .zero, title: "주문자 정보")
  let productInformationView: OrderCompletedView = .init(frame: .zero, title: "상품 정보")
  let priceInformationView: OrderCompletedView = .init(frame: .zero, title: "결제금액")
  let depositAccountNumberInformationView: OrderCompletedView = .init(frame: .zero, title: "입금계좌")
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setupView()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateView(with orderCompletedProduct: OrderCompletedProduct) {
    orderedUserInformationView.updateContent(with: orderCompletedProduct.orderedUserInformation)
    productInformationView.updateContent(with: orderCompletedProduct.productInformation)
    priceInformationView.updateContent(with: orderCompletedProduct.price.decimalWon())
    depositAccountNumberInformationView.updateContent(with: orderCompletedProduct.depositAccountNumber)
  }
}

private extension OrderCompletedStackView {
  
  func setupView() {
    axis = .vertical
    distribution = .fillEqually
    spacing = 5
    
    addArrangedSubview(orderedUserInformationView)
    addArrangedSubview(productInformationView)
    addArrangedSubview(priceInformationView)
    addArrangedSubview(depositAccountNumberInformationView)
  }
}
