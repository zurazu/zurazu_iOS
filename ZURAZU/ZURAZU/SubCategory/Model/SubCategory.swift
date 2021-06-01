//
//  SubCategory.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/30.
//

import Foundation

struct SubCategory: Decodable {
  
  let idx: Int
  let mainCategoryIdx: Int
  let korean: String
  let english: String
  let priority: Int
}
