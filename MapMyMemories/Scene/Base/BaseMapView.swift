//
//  BaseMapView.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/26.
//

import UIKit
import NMapsMap
import SnapKit

class BaseMapView: BaseView{
    //MARK: - Properties
    lazy var mapView = NMFNaverMapView(frame: .zero)
    
    //MARK: - Configure
    ///맵뷰를 기본적으로 포함하고 있다.
    ///super메서드를 반드시 호출해야한다.
    override func configure(){
        addSubview(mapView)
    }
    
    //MARK: - SetConstraints
    ///맵뷰를 기본적으로 포함하고 있다.
    ///super메서드를 반드시 호출해야한다.
    override func setConstraints(){
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
