//
//  Extension+UIViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/05.
//

import UIKit
import Toast

extension UIViewController{
    
    func makeToastMessage(_ message: String, title: String? = nil, image: UIImage? = nil,completion:((Bool) -> Void)? = nil){
        self.view.makeToast(message,title: title,image: image, completion: completion)
    }
    
    
}
