//
//  BaseResponse.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/27.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
  
  let id: String
  let dateTime: String
  let status: String
  let message: String
  let list: T?
}
