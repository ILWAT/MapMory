//
//  MemoryDB.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/28.
//

import Foundation
import RealmSwift

class MemoryDB: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String  = ""//제목
    @Persisted var address: AddressData?
    @Persisted var memo: String = "" //메모
    @Persisted var tag: List<TagDB> //태그
    @Persisted var emotion: List<EmotionDB> //감정
    @Persisted var date: Date = Date() //기록 시간
    @Persisted var memoryDate: Date = Date() //추억의 시간
    @Persisted var imageURL: MutableSet<String> //이미지 URL
    
    convenience init(_id: ObjectId, title: String, address: AddressData? = nil, memo: String, tag: List<TagDB>, emotion: List<EmotionDB>, date: Date, memoryDate: Date, imageURL: MutableSet<String>) {
        self.init()
        self._id = _id
        self.title = title
        self.address = address
        self.memo = memo
        self.tag = tag
        self.emotion = emotion
        self.memoryDate = memoryDate
        self.imageURL = imageURL
    }
    
    
}

class AddressData: Object{
    @Persisted var addressName: String = ""
    //위경도
    @Persisted var lat: Double = 0
    @Persisted var long: Double = 0
    @Persisted var placeName: String?
    
    convenience init(addressName: String, lat: Double, long: Double, placeName: String? = nil) {
        self.init()
        self.addressName = addressName
        self.lat = lat
        self.long = long
        self.placeName = placeName
    }
}

class TagDB: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var tag: String = ""
    @Persisted var tagDate: Date = Date()
    
    convenience init(tag: String, tagDate: Date) {
        self.init()
        self.tag = tag
        self.tagDate = tagDate
    }
}

class EmotionDB: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var emotion: String = ""
    @Persisted var emotionDate: Date = Date()
    
    convenience init(emotion: String, emotionDate: Date) {
        self.init()
        self.emotion = emotion
        self.emotionDate = emotionDate
    }
}
