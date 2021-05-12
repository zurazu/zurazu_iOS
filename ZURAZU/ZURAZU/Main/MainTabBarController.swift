//
//  MainTabBarController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/12.
//

import UIKit
import Combine
import CombineCocoa

class MainTabBarController: UITabBarController {
  
  private let homeButtonRadius: CGFloat = .init(27.5)
  private let homeButtonDiameter: CGFloat = .init(55)
  private lazy var homeButton: UIButton = {
    let button: UIButton = .init(frame: CGRect(
                                  x: (view.bounds.width / 2) - homeButtonRadius,
                                  y: -20,
                                  width: homeButtonDiameter,
                                  height: homeButtonDiameter))
    button.addTarget(self, action: #selector(tappedHomeButton(sender:)), for: .touchUpInside)
    //MARK: - 이미지 및 속성 수정해야 함.
    button.setImage(UIImage(systemName: "xmark"), for: .normal)
    button.backgroundColor = .blue
    button.layer.cornerRadius = button.frame.height / 2
    
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
}

private extension MainTabBarController {
  
  func setupView() {
    tabBar.addSubview(homeButton)
  }
  
  @objc func tappedHomeButton(sender: UIButton) {
    self.selectedIndex = 2
  }
}
