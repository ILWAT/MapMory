//
//  ViewingEmotionwCollectionViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/19/23.
//

import UIKit

class ViewingImageCollectionViewCell: BaseCollectionViewCell{
    //MARK: - Properties
    let imageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func setConstratins() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
