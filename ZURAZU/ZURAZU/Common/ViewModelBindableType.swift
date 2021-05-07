//
//  ViewModelBindableType.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/07.
//

import UIKit

protocol ViewModelBindableType {
  
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  
  func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
  
  mutating func bind(viewModel: ViewModelType) {
    self.viewModel = viewModel
    self.loadViewIfNeeded()
    
    self.bindViewModel()
  }
}
