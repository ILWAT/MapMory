//
//  ToastMessageType.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/10.
//

import Foundation

enum ToastMessageType{
    case network
    case noneInputText
    case failedloadLocation
    
    
    var getMessage: String{
        switch self {
        case .network:
            return "네트워크 확인 후 다시 시도해주세요."
        case .noneInputText:
            return "필수 입력 값을 입력해주세요."
        case .failedloadLocation:
            return "위치 서비스 권한 허용을 확인해주세요."
        }
    }
    
    var getTitle: String?{
        switch self {
        case .network:
            return "네트워크 연결에 실패했습니다."
        case .noneInputText:
            return nil
        case .failedloadLocation:
            return "위치 서비스를 불러오는데 실패했습니다."
        }
    }
}
