//
//  HomeView.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/30.
//

import UIKit
import Floaty
import CoreLocationUI

final class HomeView: BaseMapView{
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    let floatingButton = {
        let view = Floaty()
        view.buttonColor = .mainTintColor ?? view.buttonColor        
        view.openAnimationType = .slideUp
        return view
    }()
    
    let locationButton = {
        let button = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.tintColor = .white
//        button.backgroundColor =
        button.icon = .arrowFilled
        button.label = .none
        button.cornerRadius = 25.0
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        return button
    }()
    
    
    //MARK: - Configure
    override func configure() {
        super.configure()
        
        addSubViews([floatingButton,collectionView, locationButton])
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
        locationButton.snp.makeConstraints { make in
            make.bottom.leading.equalTo(safeAreaLayoutGuide).inset(30)
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
