//
//  Scene.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/10.
//

import UIKit

protocol Scene {
  
  var storyboard: String { get }
  
  func instantiate(from storyboard: String) -> UIViewController
}
