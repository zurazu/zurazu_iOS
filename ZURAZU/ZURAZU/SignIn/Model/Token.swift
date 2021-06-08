//
//  Token.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import Foundation

struct Token: Decodable, Hashable {
  
  let accessToken: String
  let refreshToken: String
}
