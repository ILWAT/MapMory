//
//  BaseCollectionViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/17/23.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell{
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        setConstratins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        
    }
    
    func setConstratins() {
        
    }
}
