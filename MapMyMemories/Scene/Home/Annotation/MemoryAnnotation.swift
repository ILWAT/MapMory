//
//  Annotation.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/17/23.
//

import MapKit
import RealmSwift


class MemoryAnnotation: NSObject, MKAnnotation{
    
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var memoryData: List<Memory>
    
    init(coordinate: CLLocationCoordinate2D, memoryData: List<Memory>) {
        self.coordinate = coordinate
        self.memoryData = memoryData
    }
    
}
