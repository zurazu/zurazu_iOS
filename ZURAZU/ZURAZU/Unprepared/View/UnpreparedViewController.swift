//
//  UnpreparedViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/19.
//

import UIKit

final class UnpreparedViewController: CompleteViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBarController?.tabBar.isHidden = false
  }
}

extension UnpreparedViewController {
  
  func setupView() {
    homeButton.isHidden = true
    updateGuideText(with: "준비중인 화면입니다.")
  }
}
