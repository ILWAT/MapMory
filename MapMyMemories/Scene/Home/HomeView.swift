//
//  HomeView.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/30.
//

import UIKit

final class HomeView: BaseMapView{
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    //MARK: - Configure
    override func configure() {
        super.configure()
        mapView.showZoomControls = true
        mapView.showLocationButton = true
        
        addSubViews([collectionView])
    }
    
    
    //MARK: - setConstraints
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalToSuperview()
        }
    }
    
    //MARK: - Helper
    private func configureCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(10)
        let itemWidth = (self.window?.screen.bounds.width ?? self.frame.width - spacing) * 0.8
        
        layout.itemSize = CGSize(width: itemWidth, height: 100)
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
}
