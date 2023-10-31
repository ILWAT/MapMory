//
//  SummaryCollectionViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/17/23.
//

import UIKit
import SnapKit

final class SummaryCollectionViewCell: BaseCollectionViewCell{
    //MARK: - Properties
    let thumbnailImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.tintColor = .mainTintColor
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "데이터 로드에 실패했습니다."
        label.font = .systemFont(ofSize: defaultFontSize)
        label.numberOfLines = 1
        return label
    }()
    
    let locationLabel = {
        let label = UILabel()
        label.text = "데이터 로드에 실패했습니다."
        label.font = .systemFont(ofSize: defaultFontSize)
        label.numberOfLines = 1
        return label
    }()
    
    
    //MARK: - ConfigureHierarchy
    override func configureHierarchy() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        contentView.backgroundColor = .white
        contentView.addSubViews([thumbnailImageView, titleLabel, locationLabel])
    }
    
    //MARK: - SetConstratins
    override func setConstratins() {
        let interItemDefualtSapce = 10
        thumbnailImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(interItemDefualtSapce)
            make.width.equalTo(thumbnailImageView.snp.height)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(interItemDefualtSapce)
            make.trailing.equalToSuperview().inset(interItemDefualtSapce)
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(interItemDefualtSapce)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
    
    //MARK: - setUI
    func setCellUI(image: UIImage?, title: String, location: String){
        thumbnailImageView.image = image
        titleLabel.text = title
        locationLabel.text = location
    }
    
}


