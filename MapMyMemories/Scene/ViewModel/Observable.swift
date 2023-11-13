//
//  Observable.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/11.
//

import Foundation

class Observable<T>{
    private var notifier: ((T)->Void)?
    
    var value: T {
        didSet{
            notifier?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T)->Void){
        self.notifier = closure
    }
    
    
}
