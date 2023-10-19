//
//  DetailViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/19/23.
//

import UIKit

final class DetailViewController: BaseViewController{
    //MARK: - Properties
    let mainView = DetailView()
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    //MARK: - configure
    override func configure() {
        
    }
    
    //MARK: - setNavigation
    override func setNavigation() {
        
    }
    
    
}
