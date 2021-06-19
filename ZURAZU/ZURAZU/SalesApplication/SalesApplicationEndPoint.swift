//
//  SalesApplicationEndPoint.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/06/18.
//

import Foundation
import UIKit

enum SalesApplicationEndPoint {
  
  case requestSalesApplication(inforamtion: SalesApplicationInformation)
}

struct SalesApplicationInformation {
  
  let categoryIdx: Int
  let brandName: String
  let purchasePrice: Int
  let desiredPrice: Int
  let clothingSize: String
  let clothingStatus: Int
  let comments: String
  let images: [UIImage]

}

extension SalesApplicationEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .requestSalesApplication:
      guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.salesApplication.rawValue)
      else { fatalError() }
      
      return url
    }
  }
  
  var query: HTTPQuery? {
    switch self {
    case .requestSalesApplication(let information):
      return [
        "categoryIdx": information.categoryIdx,
        "brandName": information.brandName,
        "purchasePrice": information.purchasePrice,
        "desiredPrice": information.desiredPrice,
        "clothingSize": information.clothingSize,
        "clothingStatus": information.clothingStatus,
        "comments": information.comments
      ]
    }
  }
  
  var httpMethod: HTTPMethod? {
    return .post
  }
  
  var headers: HTTPHeader? {
    return [
//      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authentication": Authorization.shared.accessToken ?? ""
    ]
  }
  
  var bodies: HTTPBody? {
    return nil
//    switch self {
//    
//    case .requestSalesApplication(let inforamtion) :
//      var dictionary: [String: Any] = [:]
//    
//      for (index, image) in inforamtion.images.enumerated() {
//        dictionary["image\(index)"] = image.jpegData(compressionQuality:0)!
//      }
//      print(dictionary.count)
//      return dictionary
//    }
  }
}
