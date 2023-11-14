//
//  WriteViewModel.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/11.
//

import UIKit

enum WriteType{
    case add
    case modify
}

final class WriteViewModel{
    //MARK: - Properties
    let date = Observable(value: Date())
    let images = Observable<[UIImage]>(value: [])
    let emotion = Observable<[String]>(value: [])
    let titleString = Observable<String?>(value: "")
    let memoString = Observable<String?>(value: "")
    
    lazy var dateText = Observable(value: dateToString(date: Date()))
    
    let dateFormat = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY. MM. dd. a hh:mm"
        return formatter
    }()
    
    enum TextType{
        case title
        case memo
    }
    
    //MARK: - initializer
    init(){
        bind()
    }
    
    private func bind(){
        date.bind { date in
            self.dateText.value = self.dateToString(date: date)
        }
    }
    
    //MARK: - Helper
    func dateToString(date: Date) -> String{
        return dateFormat.string(from: date)
    }
    
    func checkTextValidation(textType: TextType) -> String?{
        switch textType {
        case .title:
            guard let memoryTitle = titleString.value, memoryTitle != "" else {
                return nil
            }
            return memoryTitle
        case .memo:
            guard let memoryMemo = memoString.value, memoryMemo != "" else {
                return nil
            }
            return memoryMemo
        }
    }
    
    func setViewModel(data: Memory) {
        print(data)
        self.titleString.value = data.title
        self.date.value = data.memoryDate
        self.memoString.value = data.memo
        
        data.imageURL.forEach { imageURLs in
            if let image = DocumentFileManager.shared.loadImageFromDocument(fileName: .jpeg(fileName: imageURLs)){
                self.images.value.append(image)
            }
        }
        data.emotion.forEach { value in
            self.emotion.value.append(value.emotion)
        }
    }
    
    
}
