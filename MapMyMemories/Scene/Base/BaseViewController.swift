//
//  BaseViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/25.
//

import UIKit

class BaseViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setNavigation()
    }
   
    ///addTarget 등을 수행하는 작업을 수행하는 메서드
    func configure(){}
    
    ///네비게이션을 구성하는 작업을 수행하는 메서드
    func setNavigation(){}
}
