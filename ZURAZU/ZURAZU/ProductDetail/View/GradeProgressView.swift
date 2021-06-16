//
//  GradeProgressView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/15.
//

import UIKit

final class GradeProgressView: UIView {
  
  private var backgroundLayer: CAShapeLayer = .init()
  private var progressLayer: CAShapeLayer = .init()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    setupPath()
  }
  
  func progressAnimation(to grade: CGFloat) {
    let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    progressAnimation.duration = 0.4
    progressAnimation.toValue = grade
    progressAnimation.fillMode = .forwards
    progressAnimation.isRemovedOnCompletion = false
    progressLayer.add(progressAnimation, forKey: "progressAnimation")
  }
}

private extension GradeProgressView {
  
  func setupPath() {
    let path = makePath()
    backgroundLayer.path = path.cgPath
    backgroundLayer.lineCap = .round
    backgroundLayer.lineWidth = 16
    backgroundLayer.strokeColor = UIColor.monoQuinary.cgColor
    backgroundLayer.fillColor = UIColor.clear.cgColor
    
    progressLayer.path = path.cgPath
    progressLayer.lineCap = .round
    progressLayer.lineWidth = 11
    progressLayer.strokeEnd = 0
    progressLayer.strokeColor = UIColor.bluePrimary.cgColor
    progressLayer.fillColor = UIColor.clear.cgColor
    
    layer.addSublayer(backgroundLayer)
    layer.addSublayer(progressLayer)
  }
  
  func makePath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: bounds.minX + 5, y: bounds.maxY / 2))
    path.addLine(to: CGPoint(x: bounds.maxX - 5, y: bounds.maxY / 2))
    
    return path
  }
}
