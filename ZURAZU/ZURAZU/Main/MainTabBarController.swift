//
//  MainTabBarController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/12.
//

import UIKit
import Combine
import CombineCocoa

final class MainTabBarController: UITabBarController {
  
  private let homeButtonRadius: CGFloat = .init(27.5)
  private let homeButtonDiameter: CGFloat = .init(55)
  private lazy var homeButton: UIButton = {
    let button: UIButton = .init(frame: CGRect(
                                  x: (view.bounds.width / 2) - homeButtonRadius,
                                  y: -13,
                                  width: homeButtonDiameter,
                                  height: homeButtonDiameter))
    button.addTarget(self, action: #selector(tappedHomeButton(sender:)), for: .touchUpInside)
    button.setImage(#imageLiteral(resourceName: "homeButtonImage"), for: .normal)
    button.layer.cornerRadius = button.frame.height / 2
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
}

private extension MainTabBarController {
  
  var tabBarItems: [UITabBarItem] {
    return tabBar.items ?? []
  }
  
  func setupView() {
    tabBar.addSubview(homeButton)
    selectedIndex = tabBarItems.centerIndex
    tabBar.tintColor = .bluePrimary
    tabBarItems[tabBarItems.centerIndex].isEnabled = false
  }
  
  @objc func tappedHomeButton(sender: UIButton) {
    selectedIndex = tabBarItems.centerIndex
  }
}
