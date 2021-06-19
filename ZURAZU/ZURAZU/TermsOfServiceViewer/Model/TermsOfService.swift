//
//  TermsOfService.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import Foundation

struct TermsOfService: Decodable, Hashable {
  
  let terms: TermsContent
  
  struct TermsContent: Decodable, Hashable {
    
    let title: String
    let content: String
  }
}
