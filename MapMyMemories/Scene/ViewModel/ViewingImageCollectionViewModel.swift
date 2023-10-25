//
//  ViewingImageCollectionViewModel.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/24/23.
//

import UIKit

final class ViewingImageCollectionViewModel{
    let imageContentMode: Observable<UIView.ContentMode> = Observable(value: .scaleAspectFill)
    
    var image: Observable<UIImage> = Observable(value: UIImage(systemName: "camera.aperture")!) 
}
