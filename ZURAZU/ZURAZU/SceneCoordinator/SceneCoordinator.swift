//
//  SceneCoordinator.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/10.
//

import UIKit
import Combine

final class SceneCoordinator {
  
  static let shared: SceneCoordinator = .init()
  
  private var window: UIWindow?

  private var currentViewController: UIViewController?
  
  private init() { }
  
  func setup(with window: UIWindow) {
    self.window = window
  }
  
  @discardableResult
  func tabTransition(item: TabItem? = nil) -> AnyPublisher<Void, TransitionError> {
    return Future { [weak self] promise in
      // MARK: - 로직 수정 필요함 ㅠㅠ
      guard
        let tabBarController: UITabBarController = self?.window?.rootViewController as? UITabBarController,
        let tabBarItems: [UIViewController] = tabBarController.viewControllers
      else {
        promise(.failure(TransitionError.unknown))
        return
      }
      
      let index: Int = item?.rawValue ?? tabBarController.selectedIndex
      
      let viewController: UIViewController = tabBarItems[index]
      
      tabBarController.selectedViewController = tabBarItems[index]
      
      guard let navigationController: UINavigationController = viewController as? UINavigationController else {
        self?.currentViewController = viewController
        
        promise(.success(()))
        return
      }
      
      self?.currentViewController = navigationController.viewControllers.last
      promise(.success(()))
    }
    .receive(on: Scheduler.main)
    .eraseToAnyPublisher()
  }
  
  @discardableResult
  func transition(scene: Scene, using style: TransitionStyle, animated: Bool) -> AnyPublisher<Void, TransitionError> {
    return Future { [weak self] promise in
      let target: UIViewController = scene.instantiate()
      
      switch style {
      case .root:
        self?.currentViewController = target
        self?.window?.rootViewController = target
        promise(.success(()))
        
      case .push:
        guard let navigationController: UINavigationController = self?.currentViewController?.navigationController else {
          promise(.failure(TransitionError.navigationControllerMissing))
          break
        }
        navigationController.pushViewController(target, animated: animated)
        self?.currentViewController = target
        
        promise(.success(()))
        
      case .present:
        target.providesPresentationContextTransitionStyle = true
        target.definesPresentationContext = true
        target.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        target.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.5)
        
        self?.currentViewController?.present(target, animated: animated) {
          promise(.success(()))
        }
        self?.currentViewController = target
      }
    }
    .receive(on: Scheduler.main)
    .eraseToAnyPublisher()
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
        return
      }
      
      if let tabbarController = self?.currentViewController?.presentingViewController as? UITabBarController {
        if let navigationController = tabbarController.selectedViewController as? UINavigationController {
          self?.currentViewController?.dismiss(animated: animated) { [weak self] in
            self?.currentViewController = navigationController.topViewController
            promise(.success(()))
            return
          }
        } else {
          self?.currentViewController?.dismiss(animated: animated) { [weak self] in
            self?.currentViewController = tabbarController.selectedViewController
            promise(.success(()))
            return
          }
        }
      } else {
        let target = self?.currentViewController
        self?.currentViewController = (target?.presentingViewController as? UINavigationController)?.viewControllers.last
        target?.dismiss(animated: animated) {
          promise(.success(()))
        }
      }
    }
    .receive(on: Scheduler.main)
    .eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToHome() -> AnyPublisher<Void, TransitionError> {
    return Future { [weak self] promise in
      self?.currentViewController?.navigationController?.popToRootViewController(animated: true)
      self?.tabTransition(item: .main)
      promise(.success(()))
    }
    .eraseToAnyPublisher()
  }
}
