//
//  Annotation.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/17/23.
//

import MapKit


class MemoryAnnotation: NSObject, MKAnnotation{
    
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var memoryData: MemoryDB
    
    init(coordinate: CLLocationCoordinate2D, memoryData: MemoryDB = MemoryDB()) {
        self.coordinate = coordinate
        self.memoryData = memoryData
    }
    
}
