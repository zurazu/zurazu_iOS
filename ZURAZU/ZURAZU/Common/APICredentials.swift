//
//  APICredentials.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/28.
//

import Foundation

enum APICredentials: String {
  
  case baseURL = "http://api.zurazu.com"
  case mainCategories = "/mainCategories"
  case subCategories = "/subCategories"
  case categoryProducts = "/product"
  case signIn = "/member/login"
}
