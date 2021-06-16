//
//  ProductDetail.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import Foundation

struct ProductDetail: Decodable, Hashable {
  
  let product: Product?
  let images: [ProductImage]
}

struct Product: Decodable, Hashable {
  
  let idx: Int
  let subCategory: SubCategoryOfDetail
  let colorChip: ColorChip
  let applySellProductIdx: Int
  let name: String
  let brand: String
  let price: Int
  let material: String
  let clothingStatus: String
  let inspectionStatus: Int
  let clothingSize: String
  let infoComment: String
  let laundryComment: String
  let searchKeyword: String
  let saleStatus: String
  let registerNumber: String
  let createDate: String?
}

struct ProductImage: Decodable, Hashable {
  
  let idx: Int
  let registerProductIdx: Int
  let url: String
  let createDate: String?
}

struct SubCategoryOfDetail: Decodable, Hashable {
  
  let idx: Int
  let mainCategory: MainCategory?
  let korean: String
  let english: String?
  let priority: Int
}

struct ColorChip: Decodable, Hashable {
  
  let idx: Int
  let registerProductIdx: Int
  let colorText: String
  let url: String
  let createDate: String?
}
