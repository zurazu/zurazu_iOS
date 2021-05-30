//
//  Scheduler.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/30.
//

import Foundation


final class Scheduler {
  
  static var background: OperationQueue = {
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 5
    operationQueue.qualityOfService = QualityOfService.userInitiated
    
    return operationQueue
  }()
  
  static let main = DispatchQueue.main
}
