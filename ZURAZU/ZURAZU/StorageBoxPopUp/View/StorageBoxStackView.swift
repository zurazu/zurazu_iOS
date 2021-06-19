//
//  StorageBoxStackView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/20.
//

import UIKit

final class StorageBoxStackView: UIStackView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension StorageBoxStackView {
  
  func setupView() {
    axis = .vertical
    distribution = .fillProportionally
    spacing = 10
    makeStackView()
  }
  
  func makeStackView() {
    StorageBoxInformation.allCases.forEach {
      let informationView: StorageBoxInformationView = .init(frame: .zero, title: $0.title, information: $0.information)
      
      addArrangedSubview(informationView)
    }
  }
}
