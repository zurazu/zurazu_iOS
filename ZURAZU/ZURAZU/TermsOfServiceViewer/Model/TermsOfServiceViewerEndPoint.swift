//
//  TermsOfServiceViewerEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/18.
//

import Foundation

enum TermsOfServiceType: String {
  
  case accessTerms
  case privacyTerms
}

enum TermsOfServiceViewerEndPoint {
  
  case requestTermsOfService(termsOfServiceType: TermsOfServiceType)
}

extension TermsOfServiceViewerEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.terms.rawValue)
    else { fatalError() }
    
    return url
  }
  
  var query: HTTPQuery? {
    switch self {
    case .requestTermsOfService(let termsOfServiceType):
      return [
        "type": termsOfServiceType.rawValue
      ]
    }
  }
  
  var httpMethod: HTTPMethod? {
    return .get
  }
  
  var headers: HTTPHeader? {
    return [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
  }
  
  var bodies: HTTPBody? {
    return nil
  }
}
