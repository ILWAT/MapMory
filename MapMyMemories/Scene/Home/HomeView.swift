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
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.isHidden = true
        view.backgroundColor = .clear
        view.register(SummaryCollectionViewCell.self, forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier)
       return view
    }()
    
    
    let floatingButton = {
        let view = Floaty()
        view.buttonColor = .mainTintColor ?? view.buttonColor        
        view.openAnimationType = .slideUp
        return view
    }()
    
    let locationButton = {
        let button = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.tintColor = .black
        button.backgroundColor = .mainTintColor
        button.icon = .arrowFilled
        button.label = .none
        button.cornerRadius = 25.0
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
//        button.
        return button
    }()
    
    
    //MARK: - Configure
    override func configure() {
        super.configure()

        addSubViews([floatingButton, locationButton, collectionView])
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
        collectionView.snp.makeConstraints { make in
            make.width.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    //MARK: - Helper
    private func configureCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(10)
        let itemWidth = (self.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width) - (spacing * 2)
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: 150)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
}
