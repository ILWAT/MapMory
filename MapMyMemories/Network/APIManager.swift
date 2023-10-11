//
//  APIManager.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/09.
//

import Foundation
import Alamofire

class APIManager{
    
    deinit{ print("deinit APIManager") }
    
    func requestAPI<T: Decodable>(type: T.Type, api: Router, completionHandler: @escaping(Result<T,Error>) -> Void){
        AF.request(api).validate().responseDecodable(of:T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
}
