//
//  WriteViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/01.
//

import UIKit
import PhotosUI

final class WriteViewController: BaseViewController{
    
    let mainView = WriteView()
    
    var images: [UIImage] = []{
        didSet{
            mainView.imageCollectionView.reloadData()
        }
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func configure() {
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
    }
    
    override func setNavigation() {
        self.title = "추억 기록 하기"
    }
    
    //MARK: - Action
    @objc func tappedAddImageBtn(_ sender: UIButton){
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 3
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    //MARK: - Helper
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension WriteViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        images = []
        
        results.forEach { result in
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self){
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async {
                            self.images.append(selectedImage)
                        }
                    }
                }
            }
        }
        
    }
    
    
}


extension WriteViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case collectionViewType.image.getViewType:
            return images.count + 1
            
        case collectionViewType.emotion.getViewType:
            return 0
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        case collectionViewType.image.getViewType:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            
            cell.addImageButton.addTarget(self, action: #selector(tappedAddImageBtn), for: .touchUpInside)
            
            if indexPath.item == 0{
                cell.addImageButton.isHidden = false
                cell.imageView.image = nil
            } else {
                cell.imageView.image = images[indexPath.item-1]
                cell.addImageButton.isHidden = true
            }
            
            return cell
        case collectionViewType.emotion.getViewType:
           return UICollectionViewCell()
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag{
        case collectionViewType.image.getViewType:
            if indexPath.item == 0{
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 3
                configuration.filter = .images
                
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                
                self.present(picker, animated: true)
            }
            
        case collectionViewType.emotion.getViewType:
            break
            
        default:
            break
        }
    }
    
    
}
