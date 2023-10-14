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
    
    
    var getMessage: String{
        switch self {
        case .network:
            return "네트워크 확인 후 다시 시도해주세요."
        case .noneInputText:
            return "필수 입력 값을 입력해주세요."
        }
    }
    
    var getTitle: String?{
        switch self {
        case .network:
            return "네트워크 연결에 실패했습니다."
        case .noneInputText:
            return nil
        }
    }
}
