//
//  FullInfoStackView.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/19.
//

import UIKit

final class FullInfoStackView: UIStackView {

  let colorInfoView: FullInfoStackViewItem = .init(frame: .zero, title: "브랜드 및 구매처")
  let sizeInfoView: FullInfoStackViewItem = .init(frame: .zero, title: "세탁 및 취급 방법")
  let materialInfoView: FullInfoStackViewItem = .init(frame: .zero, title: "제품 상세정보")
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setupView()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateView(with data: FullInfo) {
    colorInfoView.updateContent(with: data.brand)
    sizeInfoView.updateContent(with: data.washing)
    materialInfoView.updateContent(with: data.details)
  }
}

private extension FullInfoStackView {
  
  func setupView() {
    axis = .vertical
    distribution = .equalSpacing
    spacing = 25
    
    addArrangedSubview(colorInfoView)
    addArrangedSubview(sizeInfoView)
    addArrangedSubview(materialInfoView)
  }
}

struct FullInfo {
  let brand: String
  let washing: String
  let details: String
}
