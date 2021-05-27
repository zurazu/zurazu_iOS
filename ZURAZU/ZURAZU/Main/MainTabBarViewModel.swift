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
  
  private let sceneCoordinator: SceneCoordinatorType
  
  init(sceneCoordinator: SceneCoordinatorType) {
    self.sceneCoordinator = sceneCoordinator
  }
  
  func tabItemDidSelect() {
    sceneCoordinator.tabTransition()
  }
}
