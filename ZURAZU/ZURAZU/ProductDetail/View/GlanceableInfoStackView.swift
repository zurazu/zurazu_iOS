//
//  GlanceableInfoStackView.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/19.
//

import UIKit

final class GlanceableInfoStackView: UIStackView {

  let colorInfoView: GlanceableInfoStackViewItem = .init(frame: .zero, title: "색상")
  let sizeInfoView: GlanceableInfoStackViewItem = .init(frame: .zero, title: "사이즈")
  let materialInfoView: GlanceableInfoStackViewItem = .init(frame: .zero, title: "소재")
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setupView()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateView(with data: GlanceableInfo) {
    colorInfoView.updateContent(with: data.color)
    sizeInfoView.updateContent(with: data.size)
    materialInfoView.updateContent(with: data.material)
  }
}

private extension GlanceableInfoStackView {
  
  func setupView() {
    axis = .vertical
    distribution = .fillEqually
    spacing = 10
    
    addArrangedSubview(colorInfoView)
    addArrangedSubview(sizeInfoView)
    addArrangedSubview(materialInfoView)
  }
}

struct GlanceableInfo {
  let color: String
  let size: String
  let material: String
}
