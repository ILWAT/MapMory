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
    
    var addressData: AddressData
    
    init(addressData: AddressData) {
        self.addressData = addressData
        self.coordinate = CLLocationCoordinate2D(latitude: addressData.lat, longitude: addressData.long)
    }
    
}
