//
//  TransitionModel.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/10.
//

import Foundation

enum TransitionStyle {
  
  case root
  case push
  case present
}

enum TransitionError: Error {
  
  case navigationControllerMissing
  case cannotPop
  case unknown
}
