//
//  SectionModel.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/28.
//

import Foundation
import UIKit

enum SalesApplicationSectionStyle {
  
  case input
  case picker
  case picture
}

protocol SalesApplicationSectionModel {
  
  var style: SalesApplicationSectionStyle { get }
  var title: String { get }
  var subtitle: String? { get }
  var isNecessary: Bool { get }
  var height: CGFloat { get }
  var headerHeight: CGFloat { get }
  
  var content: String { get set }
}

class SalesApplicationSectionInputModel: SalesApplicationSectionModel {
  
  var content: String = ""
  
  let height: CGFloat
  let headerHeight: CGFloat
  let isNecessary: Bool
  let style: SalesApplicationSectionStyle = .input
  let title: String
  let placeHolder: String?
  let description: String?
  let subtitle: String?
  
  init(title: String, subTitle: String? = nil, placeHolder: String? = nil, height: CGFloat = 30, headerHeight: CGFloat = 30, isNecessary: Bool = false, subtitle: String? = nil) {
    self.title = title
    self.placeHolder = placeHolder
    self.height = height
    self.headerHeight = headerHeight
    self.subtitle = subtitle
    self.description = subTitle
    self.isNecessary = isNecessary
  }
}

class SalesApplicationSectionPickerModel: SalesApplicationSectionModel {
  
  var content: String = ""
  let height: CGFloat
  let headerHeight: CGFloat
  let isNecessary: Bool
  let style: SalesApplicationSectionStyle = .picker
  let title: String
  let subtitle: String?
  var items: [String]
  
  init(title: String, subtitle: String? = nil, height: CGFloat = 50, headerHeight: CGFloat = 30, isNecessary: Bool = false, items: [String] = []) {
    self.title = title
    self.height = height
    self.headerHeight = headerHeight
    self.subtitle = subtitle
    self.isNecessary = isNecessary
    self.items = items
  }
}

class SalesApplicationSectionPictureModel: SalesApplicationSectionModel {
  
  var content: String = ""
  var height: CGFloat
  let headerHeight: CGFloat
  var isNecessary: Bool
  let style: SalesApplicationSectionStyle = .picture
  let title: String
  let subtitle: String?
  var images: [UIImage] = []
  
  init(title: String, subtitle: String? = nil, height: CGFloat = 104, headerHeight: CGFloat = 30, isNecessary: Bool = false) {
    self.title = title
    self.height = height
    self.headerHeight = headerHeight
    self.subtitle = subtitle
    self.isNecessary = isNecessary
  }
}
