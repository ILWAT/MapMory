//
//  SelectDateView.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/10.
//

import UIKit

final class SelectDateView: BaseView{
    //MARK: - Properties
    let picker = {
        let view = UIDatePicker(frame: .zero)
        view.datePickerMode = .dateAndTime
        view.preferredDatePickerStyle = .inline
        return view
    }()
    
    override func configure() {
        addSubViews([picker])
    }
    
    override func setConstraints() {
        picker.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
