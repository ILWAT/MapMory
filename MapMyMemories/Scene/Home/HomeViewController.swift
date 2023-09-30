//
//  HomeViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/26.
//

import UIKit

final class HomeViewController: BaseViewController{
    //MARK: - Properties
    let mainView = HomeView()
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    
    
    //MARK: - Configure
    override func configure() {
    }
    
    
    //MARK: - SetNavigation
    override func setNavigation() {
        
    }
    
    //MARK: - Action
    
    //MARK: - Helper
}
