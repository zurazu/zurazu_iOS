//
//  OrderEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/20.
//

import Foundation

enum OrderEndPoint {
  
  case requestOrderProduct(orderInformation: OrderInformation)
}

extension OrderEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.orderProduct.rawValue)
    else { fatalError() }
    
    return url
  }
  
  var query: HTTPQuery? {
    return nil
  }
  
  var httpMethod: HTTPMethod? {
    return .post
  }
  
  var headers: HTTPHeader? {
    return [
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authentication": Authorization.shared.accessToken ?? ""
    ]
  }
  
  var bodies: HTTPBody? {
    switch self {
    case .requestOrderProduct(let orderInformation):
      return [
        "customerName": orderInformation.customerName,
        "customerPhone": orderInformation.customerPhone,
        "customerEmail": orderInformation.customerEmail,
        "registerNumber": orderInformation.registerNumber,
        "purchasePrice": orderInformation.purchasePrice
      ]
    }
  }
  
  
}
