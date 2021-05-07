//
//  BaseResponse.swift
//  ZURAZUTests
//
//  Created by 서명렬 on 2021/05/07.
//

import Foundation

struct BaseUser<T: Decodable>: Decodable {
  
  let status: String
  let message: String
  let data: T?
}
