//
//  ViewingEmotionwCollectionViewCell.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/19/23.
//

import UIKit

class ViewingImageCollectionViewCell: BaseCollectionViewCell{
    //MARK: - Properties
    let imageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.image = UIImage(systemName: "camera.aperture")
        view.tintColor = .mainTintColor
        return view
    }()
    
    var isSynced: Bool = false
    
    deinit {
        print("ViewinImageCollectionViewCell deinit")
    }
    
    //MARK: - configureHierarchy
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    
    //MARK: - setConstraints
    override func setConstratins() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - Action
    @objc func changeImageContentMode(){
        switch imageView.contentMode {
        case .scaleAspectFill:
            imageView.contentMode = .scaleAspectFit
        default:
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    //MARK: - Helper
    func setImage(imageName: String, contentMode: UIView.ContentMode){
        if let image = DocumentFileManager.shared.loadImageFromDocument(fileName: .jpeg(fileName: imageName)) {
            self.imageView.image = image
        }
        self.imageView.contentMode = contentMode
    }
    
}
