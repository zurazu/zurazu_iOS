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
    guard !clipsToBounds, !isHidden, alpha > 0 else { return nil }
    
    for subview in subviews.reversed() {
      let subPoint: CGPoint = subview.convert(point, from: self)
      guard let result: UIView = subview.hitTest(subPoint, with: event) else { continue }
      
      return result
    }
    
    return nil
  }
  
  override func draw(_ rect: CGRect) {
    addShape()
  }
}

private extension MainTabBar {
  
  func addShape() {
    let newShapeLayer: CAShapeLayer = .init()
    newShapeLayer.path = createPath()
    
    //MARK: - 색상 변경 필요
    newShapeLayer.strokeColor = UIColor.lightGray.cgColor
    newShapeLayer.fillColor = UIColor.white.cgColor
    newShapeLayer.lineWidth = 1.0
    
    newShapeLayer.shadowOffset = CGSize(width: 0, height: 0)
    newShapeLayer.shadowRadius = 10
    newShapeLayer.shadowColor = UIColor.gray.cgColor
    newShapeLayer.shadowOpacity = 0.3
    
    if let oldShapeLayer = self.shapeLayer {
      layer.replaceSublayer(oldShapeLayer, with: newShapeLayer)
    } else {
      layer.insertSublayer(newShapeLayer, at: 0)
    }
    
    
    shapeLayer = newShapeLayer
  }
  
  func createPath() -> CGPath {
    let path: UIBezierPath = .init()
    
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: frame.width, y: 0))
    path.addLine(to: CGPoint(x: frame.width, y: frame.height))
    path.addLine(to: CGPoint(x: 0, y: frame.height))
    path.close()
    
    return path.cgPath
  }
}
