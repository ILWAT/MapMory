//
//  ImageCollectionViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/05.
//

import UIKit
import SnapKit

final class ImageCollectionViewCell: UICollectionViewCell{
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
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        setConstratins()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - conFigureHierarchy
    private func configureHierarchy(){
        contentView.addSubViews([imageView, addImageButton])
        addImageButton.isHidden = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.mainTintColor?.cgColor
    }
    
    //MARK: - setConstraints
    private func setConstratins(){
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addImageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
