//
//  StorageBoxInformation.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/20.
//

import Foundation

enum StorageBoxInformation: CaseIterable {
  
  case forSeller
  case forConsumer
  
  var title: String {
    switch self {
    case .forSeller: return "판매자 이용방법"
    case .forConsumer: return "구매자 이용방법"
    }
  }
  
  var information: String {
    switch self {
    case .forSeller:
      return "선택하신 시간대에 '송포어스' 를 방문하여 판매자 상품 수거칸에 의류를 넣어주세요!"
    case .forConsumer:
      return
        """
        1) 카카오톡 플러스친구로 전송된 보관함 이용 가능 일정을 확인해주세요.
        2) 원하는 일자와 시간대를 선택해주세요. 선택이 완료되면 보관함 비밀번호가 부여됩니다.
        3) 선택하신 시간대에 '송포어스'를 방문하여 보관함의 비밀번호를 입력한 뒤 옷을 찾아가주세요.
        (두시간 이후에도 찾아가지 않을 경우, 자동으로 주문 취소처리 됩니다. ***보관함 이용 후에는 문을 잘 닫아주세요.)
        4) 옷을 찾아가신 후 어플에서 ‘구매확정’ 버튼을 꼭 눌러주세요.
        """
    }
  }
}
