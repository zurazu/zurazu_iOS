//
//  Profile.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import Foundation

struct Profile: Decodable, Hashable {
  
  let name: String
  let profileImage: String
  let tradeCount: Int
  let applyCount: Int
  let purchaseCount: Int
}
