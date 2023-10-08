//
//  Extension+UIView.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/01.
//

import UIKit


extension UIView{
    static var identifier: String{
        get{
            return String(describing: self)
        }
    }
    
    func addSubViews(_ subViews: [UIView]){
        subViews.forEach { element in
            self.addSubview(element)
        }
    }
    
}

