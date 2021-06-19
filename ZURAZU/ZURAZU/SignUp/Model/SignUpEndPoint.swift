//
//  SignUpEndPoint.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/10.
//

import Foundation

enum SignUpEndPoint {
  
//  case signUp(email: String, password: String, realName: String, gender: String, birth: Date)
//  case signUp(
//        email: String,
//        password: String,
//        realName: String,
//        isAgreeTermsOfService: Bool,
//        agreeCollectionPersonalInfo: Bool,
//        agreePushNotification: Bool,
//        agreeReceiveEmail: Bool,
//        agreeReceiveSMS: Bool,
//        agreeReceiveKAKAO: Bool,
//        agreeUpperFourteen: Bool
//       )
  
  case signUp(userSignUpInformation: UserSignUpInformation)
}

extension SignUpEndPoint: EndPointable {
  
  var environmentBaseURL: String {
    return APICredentials.baseURL.rawValue
  }
  
  var baseURL: URLComponents {
    switch self {
    case .signUp:
      guard let url: URLComponents = .init(string: environmentBaseURL + APICredentials.signUp.rawValue)
      else { fatalError() }
      
      return url
    }
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
      "Accept": "application/json"
    ]
  }
  
  var bodies: HTTPBody? {
    switch self {
    case .signUp(let userSignUpInformation):
      return [
        "email": userSignUpInformation.email,
        "password": userSignUpInformation.password,
        "realName": userSignUpInformation.realName,
        "agreeTermsOfService": userSignUpInformation.agreeTermsOfService,
        "agreeCollectionPersonalInfo": userSignUpInformation.agreeCollectionPersonalInfo,
        "agreePushNotification": userSignUpInformation.agreePushNotification,
        "agreeReceiveEmail": userSignUpInformation.agreeReceiveEmail,
        "agreeReceiveSMS": userSignUpInformation.agreeReceiveSMS,
        "agreeReceiveKAKAO": userSignUpInformation.agreeReceiveKAKAO,
        "agreeUpperFourteen": userSignUpInformation.agreeUpperFourteen
      ]
    }
  }
  
  
}
