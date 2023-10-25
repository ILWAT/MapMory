//
//  ViewingEmotionCollectinoViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/22/23.
//

import UIKit

final class ViewingEmotionCollectionViewCell: BaseCollectionViewCell{
    //MARK: - Properties
    private let emotionLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - configureHierarchy
    override func configureHierarchy() {
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(emotionLabel)
    }
    
    //MARK: - setConstraints
    override func setConstratins() {
        emotionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setLabel(text: String){
        self.emotionLabel.text = text
    }
}
