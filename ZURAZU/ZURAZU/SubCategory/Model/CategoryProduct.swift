//
//  Product.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/02.
//

import Foundation

struct CategoryProducts: Decodable, Hashable {
  let products: [CategoryProduct]
}

struct CategoryProduct: Decodable, Hashable {
  
  let brand: String
  let image: CategoryProductImage
  let name: String
  let productIdx: Int
  
  struct CategoryProductImage: Decodable, Hashable {
    
    let createDate: String
    let idx: Int
    let registerProductIdx: Int
    let url: String
  }
}
