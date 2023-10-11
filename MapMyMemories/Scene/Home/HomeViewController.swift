//
//  HomeViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/26.
//

import UIKit
import Floaty

final class HomeViewController: BaseViewController{
    //MARK: - Properties
    let mainView = HomeView()
    
    
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    
    
    //MARK: - Configure
    override func configure() {
        mainView.floatingButton.addItem("기록하기", icon: UIImage(systemName: "pencil.line")) { item in
            self.navigationController?.pushViewController(WriteViewController(), animated: true)
        }
    }
    
    
    //MARK: - SetNavigation
    override func setNavigation() {
        
    }
    
    //MARK: - Action
    
    //MARK: - Helper
}
