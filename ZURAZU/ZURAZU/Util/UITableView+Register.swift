//
//  UITableView+Register.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/13.
//

import UIKit

extension UITableView {
  
  func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
    register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }
  
  func register<T: UITableViewCell>(_: T.Type) where T: Reusable, T: NibLoadable {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    
    register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
    guard let cell: T = dequeueReusableCell(
      withIdentifier: T.defaultReuseIdentifier,
      for: indexPath
    ) as? T else {
      return T()
    }
    
    return cell
  }
}
