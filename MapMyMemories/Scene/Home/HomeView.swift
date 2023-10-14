//
//  HomeView.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/30.
//

import UIKit
import Floaty

final class HomeView: BaseMapView{
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let floatingButton = {
        let view = Floaty()
        view.buttonColor = .mainTintColor ?? view.buttonColor
        view.openAnimationType = .slideUp
        return view
    }()
    
    
    //MARK: - Configure
    override func configure() {
        super.configure()
        mapView.showZoomControls = true
        mapView.showLocationButton = true
        
        addSubViews([floatingButton,collectionView])
    }
    
    
    //MARK: - setConstraints
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalToSuperview()
        }
        floatingButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(safeAreaLayoutGuide).inset(30)
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
