//
//  OrderCompleteViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/17.
//

import UIKit
import Combine

final class OrderCompleteViewController: CompleteViewController, ViewModelBindableType {
  
  var viewModel: OrderCompleteViewModelType?
  
  let dividerView: UIView = .init(frame: .zero)
  let orderCompletedStackView: OrderCompletedStackView = .init(frame: .zero)
  let storageBoxInformationButton: UIButton = .init(frame: .zero)
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
}

private extension OrderCompleteViewController {
  
  func setupView() {
    title = "주문 완료"
    
    updateGuideText(with: "입금/결제 확인 후에 상품이 보관함으로 발송됩니다.")
    
    dividerView.backgroundColor = .monoQuinary
    
    storageBoxInformationButton.backgroundColor = .bluePrimary
    storageBoxInformationButton.setTitle("보관함 이용방법 확인하기", for: .normal)
    storageBoxInformationButton.titleLabel?.font = .quaternaryBold
    storageBoxInformationButton.setTitleColor(.white, for: .normal)
    
    if let orderCompletedProduct = viewModel?.orderCompletedProduct {
      orderCompletedStackView.updateView(with: orderCompletedProduct)
    }
  }
  
  func setupConstraint() {
    [dividerView, orderCompletedStackView, storageBoxInformationButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      dividerView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 15),
      dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      dividerView.heightAnchor.constraint(equalToConstant: 2),
      
      orderCompletedStackView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 15),
      orderCompletedStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      orderCompletedStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      orderCompletedStackView.heightAnchor.constraint(equalToConstant: 150),
      
      storageBoxInformationButton.topAnchor.constraint(equalTo: orderCompletedStackView.bottomAnchor, constant: 25),
      storageBoxInformationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      storageBoxInformationButton.widthAnchor.constraint(equalToConstant: 170),
      storageBoxInformationButton.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  func binding() {
    homeButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
        self?.tabBarController?.tabBar.isHidden = false
      }
      .store(in: &cancellables)
    
    storageBoxInformationButton
      .tapPublisher
      .sink { [weak self] in
        self?.viewModel?.storageBoxPopUpEvent.send()
      }
      .store(in: &cancellables)
  }
}
