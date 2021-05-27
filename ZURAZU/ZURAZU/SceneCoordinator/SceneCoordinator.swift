//
//  SceneCoordinator.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/10.
//

import UIKit
import Combine

protocol SceneCoordinatorType {
  
  @discardableResult
  func tabTransition() -> AnyPublisher<Void, TransitionError>
  
  @discardableResult
  func transition(scene: Scene, using style: TransitionStyle, animated: Bool) -> AnyPublisher<Void, TransitionError>
  
  @discardableResult
  func close(animated: Bool) -> AnyPublisher<Void, TransitionError>
}

final class SceneCoordinator: SceneCoordinatorType {
  
  private var window: UIWindow
  private var currentViewController: UIViewController?
  
  required init(window: UIWindow) {
    self.window = window
    self.currentViewController = window.rootViewController
  }
  
  @discardableResult
  func tabTransition() -> AnyPublisher<Void, TransitionError> {
    return Future { [weak self] promise in
      // MARK: - 로직 수정 필요함 ㅠㅠ
      guard
        let tabBarController: UITabBarController = self?.window.rootViewController as? UITabBarController,
        let tabBarItems: [UIViewController] = tabBarController.viewControllers
      else {
        promise(.failure(TransitionError.unknown))
        return
      }
      
      let viewController: UIViewController = tabBarItems[tabBarController.selectedIndex]
      
      guard let navigationController: UINavigationController = viewController as? UINavigationController else {
        self?.currentViewController = viewController
        
        promise(.success(()))
        return
      }
      
      self?.currentViewController = navigationController.viewControllers.last
      promise(.success(()))
    }.eraseToAnyPublisher()
  }
  
  @discardableResult
  func transition(scene: Scene, using style: TransitionStyle, animated: Bool) -> AnyPublisher<Void, TransitionError> {
    return Future { [weak self] promise in
      let target: UIViewController = scene.instantiate()
      
      switch style {
      case .root:
        self?.currentViewController = target
        self?.window.rootViewController = target
        promise(.success(()))
        
      case .push:
        guard let navigationController: UINavigationController = self?.currentViewController?.navigationController else {
          promise(.failure(TransitionError.navigationControllerMissing))
          break
        }
        navigationController.pushViewController(target, animated: animated)
        self?.currentViewController = target
        
        promise(.success(()))
        
      case .modal:
        self?.currentViewController?.present(target, animated: animated) {
          promise(.success(()))
        }
        self?.currentViewController = target
      }
    }.eraseToAnyPublisher()
  }
  
  @discardableResult
  func close(animated: Bool) -> AnyPublisher<Void, TransitionError> {
    return Future { [weak self] promise in
      if let navigationController: UINavigationController = self?.currentViewController?.navigationController {
        guard
          navigationController.popViewController(animated: true) != nil,
          let lastViewController: UIViewController = navigationController.viewControllers.last
        else {
          promise(.failure(TransitionError.cannotPop))
          return
        }
        
        self?.currentViewController = lastViewController
        promise(.success(()))
      }
      
      if let presentingViewController: UIViewController = self?.currentViewController?.presentingViewController {
        self?.currentViewController?.dismiss(animated: animated) { [weak self] in
          self?.currentViewController = presentingViewController
          promise(.success(()))
        }
      }
      
      promise(.failure(TransitionError.unknown))
    }.eraseToAnyPublisher()
  }
}
