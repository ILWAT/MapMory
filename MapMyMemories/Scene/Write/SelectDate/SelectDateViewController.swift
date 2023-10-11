//
//  SelectDateViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/10.
//

import UIKit

class SelectDateViewController: BaseViewController{
    //MARK: - Properties
    let mainView = SelectDateView()
    
    var dateViewModel: WriteViewModel? = nil
    
    deinit{
        print("deinit" + String(describing: self))
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    //MARK: - Configure
    override func configure() {
        mainView.picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    
    //MARK: - setNavigation
    override func setNavigation() {
        
    }
    
    //MARK: - Action
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        dateViewModel?.date.value = sender.date
    }
}
