//
//  ToastMessageType.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/10.
//

import Foundation

enum ToastMessageType{
    case network
    case noneTitle
    case noneLocation
    case failedloadLocation
    case failedSaveImageDocument
    case failedRealmInit
    
    
    var getMessage: String{
        switch self {
        case .network:
            return "네트워크 확인 후 다시 시도해주세요."
        case .noneTitle:
            return "제목을 입력해주세요."
        case .failedloadLocation:
            return "위치 서비스 권한 허용을 확인해주세요."
        case .failedSaveImageDocument:
            return "이미지를 저장에 실패했습니다. 다시 시도해주세요."
        case .noneLocation:
            return "위치를 지정해주세요."
        case .failedRealmInit:
            return "앱 초기 오류가 발생했습니다.\n 앱 종료후 다시 실행해주세요."
        }
    }
    
    var getTitle: String?{
        switch self {
        case .network:
            return "네트워크 연결에 실패했습니다."
        case .failedloadLocation:
            return "위치 서비스를 불러오는데 실패했습니다."
        default:
            return nil
        }
    }
}
