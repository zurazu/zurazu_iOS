//
//  Product.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/02.
//

import Foundation

struct Products: Decodable, Hashable {
  let products: [Product]
}

struct Product: Decodable, Hashable {
  
  let brand: String
  let image: Image
  let name: String
  let productIdx: Int
  
  struct Image: Decodable, Hashable {
    
    let createDate: String
    let idx: Int
    let registerProductIdx: Int
    let url: String
  }
}
