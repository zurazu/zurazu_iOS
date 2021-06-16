//
//  UserSignUpInformation.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/07.
//

import Foundation

struct UserSignUpInformation: Decodable, Hashable {
  // MARK: - 수정해야함.
  let email: String
  let password: String
  let realName: String
//  let gender: String
//  let birth: Date
//  let phoneNumber: String?
//  let agreeTermsOfService: Bool? = false
//  let agreeCollectionPersonalInfo: Bool = false
//  let agreePushNotification: Bool
//  let agreeReceiveEmail: Bool
//  let agreeReceiveSMS: Bool
//  let agreeReceiveKAKAO: Bool
//  let agreeUpperFourteen: Bool
}
