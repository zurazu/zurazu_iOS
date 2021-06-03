//
//  Validator.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/03.
//

import Foundation

struct Validator {
  
  static func isValid(email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
    
    return predicate.evaluate(with: email)
  }
  
  static func isValid(password: String) -> Bool {
    let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
    let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
    
    return predicate.evaluate(with: password)
  }
}
