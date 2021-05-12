//
//  MainTabBar.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/12.
//

import UIKit

final class MainTabBar: UITabBar {
  
  private var shapeLayer: CALayer?
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
    for member in subviews.reversed() {
      let subPoint = member.convert(point, from: self)
      guard let result = member.hitTest(subPoint, with: event) else { continue }
      return result
    }
    return nil
  }
  
  private func addShape() {
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = createPath()
    
    //MARK: - 색상 변경 필요
    shapeLayer.strokeColor = UIColor.lightGray.cgColor
    shapeLayer.fillColor = UIColor.white.cgColor
    shapeLayer.lineWidth = 1.0
    
    shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
    shapeLayer.shadowRadius = 10
    shapeLayer.shadowColor = UIColor.gray.cgColor
    shapeLayer.shadowOpacity = 0.3
    
    if let oldShapeLayer = self.shapeLayer {
      self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
    } else {
      self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    
    self.shapeLayer = shapeLayer
  }
  
  override func draw(_ rect: CGRect) {
    self.addShape()
  }
  
  func createPath() -> CGPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: self.frame.width, y: 0))
    path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
    path.addLine(to: CGPoint(x: 0, y: self.frame.height))
    path.close()
    
    return path.cgPath
  }
}
