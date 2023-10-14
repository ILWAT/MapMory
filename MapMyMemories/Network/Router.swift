//
//  Router.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/09.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible{
    case kewordSearch(query: String)
    
    
    private var baseURL: URL{
        switch self {
        case .kewordSearch:
            return URL(string: "https://dapi.kakao.com/v2/")!
        }
    }
    
    private var endPoint: String{
        switch self {
        case .kewordSearch:
            return "local/search/keyword"
        }
    }
    
    var header: HTTPHeaders{
        switch self {
        case .kewordSearch:
            return ["Authorization" : "KakaoAK \(APIKeys.kakaoDeveloperRestAPIKey)"]
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .kewordSearch:
            return .get
        }
    }
    
    var query: [String: String]{
        switch self {
        case .kewordSearch(let query):
            return ["query" : query]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.headers = header
        request.method = method
        
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        
        return request
    }
    
    
    
    
}
