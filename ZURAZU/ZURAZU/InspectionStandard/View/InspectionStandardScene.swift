//
//  InspectionStandardScene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import UIKit

struct InspectionStandardScene: Scene {
  
  var storyboard: String {
    return "InspectionStandard"
  }
  
  func instantiate() -> UIViewController {
    guard var inspectionStandardViewController: InspectionStandardViewController = self.viewController(identifier: .inspectionStandardVC) as? InspectionStandardViewController
    else { fatalError() }
    
    let viewModel: InspectionStandardViewModel = .init()
    inspectionStandardViewController.bind(viewModel: viewModel)
    
    return inspectionStandardViewController
  }
}
