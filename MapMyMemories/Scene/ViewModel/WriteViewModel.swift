//
//  WriteViewModel.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/11.
//

import Foundation

class WriteViewModel{
    //MARK: - Properties
    let date = Observable(value: Date())
    
    lazy var dateText = Observable(value: dateToString(date: Date()))
    
    let dateFormat = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY. MM. dd. a hh:mm"
        return formatter
    }()
    
    init(){
        bind()
    }
    
    func dateToString(date: Date) -> String{
        return dateFormat.string(from: date)
    }
    
    func bind(){
        date.bind { date in
            self.dateText.value = self.dateToString(date: date)
        }
    }
    
    
}
