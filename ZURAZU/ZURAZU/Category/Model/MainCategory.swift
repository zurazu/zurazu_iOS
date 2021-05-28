//
//  MainCategory.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/27.
//

import Foundation

struct MainCategory: Decodable, Hashable {
  
  let idx: Int
  let korean: String
  let english: String
  let priority: Int
}
