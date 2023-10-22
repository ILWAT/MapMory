//
//  ViewingEmotionCollectinoViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/22/23.
//

import UIKit

class ViewingEmotionCollectinoViewCell: BaseCollectionViewCell{
    //MARK: - Properties
    let emotionLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    //MARK: - configureHierarchy
    override func configureHierarchy() {
        contentView.backgroundColor = .systemGray
        contentView.addSubview(emotionLabel)
    }
    
    //MARK: - setConstraints
    override func setConstratins() {
        emotionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
