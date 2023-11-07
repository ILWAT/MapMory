//
//  EmotionCollectionViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/13.
//

import UIKit

final class EmotionCollectionViewCell: BaseCollectionViewCell{
    //MARK: - Properteis
    let emotionLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 50)
        return view
    }()
    
    let addEmotionButton = {
        let button = UIButton()
        var configure = UIButton.Configuration.plain()
        configure.image = UIImage(systemName: "plus")
        configure.baseForegroundColor = .label
        configure.imagePlacement = .top
//        button.layer.borderColor = UIColor.mainTintColor?.cgColor
//        button.clipsToBounds = true
        button.configuration = configure
        button.isHidden = true
        return button
    }()
    
    let deleteButton = {
        let button = UIButton()
        var configure = UIButton.Configuration.plain()
        configure.image = UIImage(systemName: "x.circle.fill")
        configure.baseForegroundColor = .systemGray
        configure.imagePlacement = .trailing
        button.configuration = configure
        button.isHidden = true
        return button
    }()
    
    //MARK: - configureHierarchy
    override func configureHierarchy(){
        contentView.addSubViews([emotionLabel, addEmotionButton, deleteButton])
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.mainTintColor?.cgColor
    }
    
    //MARK: - setConstratins
    override func setConstratins(){
        emotionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addEmotionButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        deleteButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
        }
        
    }
}
