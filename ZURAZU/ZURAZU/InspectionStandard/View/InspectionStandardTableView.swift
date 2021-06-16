//
//  InspectionStandardTableView.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import UIKit

final class InspectionStandardTableView: UITableView {
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension InspectionStandardTableView {
  
  func setupView() {
    register(InspectionStandardTableViewCell.self)
    
    
//    contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    separatorInsetReference = .fromCellEdges
    
    tableFooterView = UIView()
  }
}
