//
//  MainTabBarViewModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/21.
//

import Foundation

protocol MainTabBarViewModelType {
  
  func tabItemDidSelect()
}

final class MainTabBarViewModel: MainTabBarViewModelType {
  
  func tabItemDidSelect() {
    SceneCoordinator.shared.tabTransition()
  }
}
