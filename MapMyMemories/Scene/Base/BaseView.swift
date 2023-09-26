//
//  BaseView.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/26.
//

import UIKit

class BaseView: UIView{
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    ///addSubView 등을 수행한다.
    func configure(){ }
    
    //MARK: - SetConstraints
    ///컴포넌트의 AutoLayout을 설정한다.
    func setConstraints(){}
}
