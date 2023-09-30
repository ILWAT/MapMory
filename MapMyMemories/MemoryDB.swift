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
    @Persisted var title: String //제목
    //위경도
    @Persisted var lat: Double
    @Persisted var long: Double
    @Persisted var memo: String //메모
    @Persisted var tag: List<TagDB> //태그
    @Persisted var emotion: List<EmotionDB> //감정
    @Persisted var date: Date //기록 시간
    @Persisted var imageURL: MutableSet<String> //이미지 URL
    
    
}

class TagDB: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var tag: String
}

class EmotionDB: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var emotion: String
}
