//
//  SubCategory.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/30.
//

import Foundation

struct SubCategory: Decodable, Hashable {
  
  let idx: Int
  let mainCategory: MainCategory
  let korean: String
  let english: String
  let priority: Int
}
