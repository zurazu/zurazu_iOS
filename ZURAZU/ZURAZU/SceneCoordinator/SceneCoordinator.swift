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
  func transition(scene: Scene, using style: TransitionStyle, animated: Bool) -> AnyPublisher<Never, TransitionError>
  
  @discardableResult
  func close(animated: Bool) -> AnyPublisher<Never, TransitionError>
}

final class SceneCoordinator: SceneCoordinatorType {
  
  private var cancellables: Set<AnyCancellable> = .init()
  private var window: UIWindow
  private var currentViewController: UIViewController
  
  required init?(window: UIWindow) {
    self.window = window
    
    guard let rootViewController = window.rootViewController else { return nil}
    
    self.currentViewController = rootViewController
  }
  
  @discardableResult
  func transition(scene: Scene, using style: TransitionStyle, animated: Bool) -> AnyPublisher<Never, TransitionError> {
    let subject: PassthroughSubject<Never, TransitionError> = .init()
    let target: UIViewController = scene.instantiate(from: scene.storyboard)
    
    switch style {
    case .root:
      currentViewController = target
      window.rootViewController = target
      subject.send(completion: .finished)
    case .push:
      guard let navigationController: UINavigationController = currentViewController.navigationController else {
        subject.send(completion: .failure(TransitionError.navigationControllerMissing))
        break
      }
      navigationController.pushViewController(target, animated: animated)
      currentViewController = target
      
      subject.send(completion: .finished)
    case .modal:
      currentViewController.present(target, animated: animated) {
        subject.send(completion: .finished)
      }
      currentViewController = target
    }
    
    return subject.ignoreOutput().eraseToAnyPublisher()
  }
  
  @discardableResult
  func close(animated: Bool) -> AnyPublisher<Never, TransitionError> {
    
  }
  
  
}
