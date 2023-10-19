//
//  DetailView.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/19/23.
//

import UIKit

class DetailView: BaseView{
    //MARK: - Properties
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    //MARK: - configure
    override func configure() {
        self.addSubViews([imageView, titleLabel])
    }
    
    
    //MARK: - SetConstraints
    override func setConstraints() {
        
    }
    
}
