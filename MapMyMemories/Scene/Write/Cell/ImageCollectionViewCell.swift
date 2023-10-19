//
//  ImageCollectionViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/05.
//

import UIKit
import SnapKit

final class ImageCollectionViewCell: BaseCollectionViewCell{
    //MARK: - Properteis
    let imageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let addImageButton = {
        let button = UIButton()
        var configure = UIButton.Configuration.plain()
        configure.image = UIImage(systemName: "plus")
        configure.baseForegroundColor = .black
        configure.imagePlacement = .top
        button.layer.borderColor = UIColor.mainTintColor?.cgColor
        button.clipsToBounds = true
        button.configuration = configure
        return button
    }()
    
    //MARK: - conFigureHierarchy
    override func configureHierarchy(){
        contentView.addSubViews([imageView, addImageButton])
        addImageButton.isHidden = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.mainTintColor?.cgColor
    }
    
    //MARK: - setConstraints
    override func setConstratins(){
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addImageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
