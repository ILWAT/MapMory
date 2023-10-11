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
    
    let inputData = MemoryDB()
    
    let viewModel = WriteViewModel()
    
    var images: [UIImage] = []{
        didSet{
            mainView.imageCollectionView.reloadData()
        }
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
        mainView.dateButton.setTitle(viewModel.dateText.value, for: .normal)
    }
    
    override func configure() {
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
        mainView.locationSearchButton.addTarget(self, action: #selector(tappedSearchLocationBtn), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(tappedDateBtn), for: .touchUpInside)
        setBind()
    }
    
    override func setNavigation() {
        self.title = "추억 기록 하기"
        let completButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tappedSaveBtn))
        completButton.tintColor = .black
        self.navigationItem.setRightBarButtonItems([completButton], animated: true)
    }
    
    func setBind(){
        viewModel.dateText.bind { string in
            self.mainView.dateButton.setTitle(string, for: .normal)
        }
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
    
    @objc func tappedSearchLocationBtn(_ sender: UIButton){
        let alert = UIAlertController(title: "위치 지정", message: nil, preferredStyle: .actionSheet)
        let searchLocation = UIAlertAction(title: "위치 검색하기", style: .default) { action in
            let searchVC = SearchLocationViewController()
            searchVC.delegate = self
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
        let selectLocation = UIAlertAction(title: "위치 지정하기", style: .default) { action in
            self.makeToastMessage("아직 준비중인 서비스입니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        [searchLocation, selectLocation, cancel].forEach { element in
            alert.addAction(element)
        }
        self.present(alert, animated: true)
    }
    
    @objc func tappedSaveBtn(_ sender: UIBarButtonItem){
       setInputData()
    }
    
    @objc func tappedDateBtn(_ sender: UIButton){
        let picker = SelectDateViewController()
        if let sheet = picker.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        picker.dateViewModel = viewModel
        self.present(picker, animated: true)
    }
    
    //MARK: - Helper
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setInputData(){
        guard let memoryTitle = mainView.titleTextField.text, memoryTitle != "" else {
            makeToastMessage(errorType: .noneInputText)
            return }
        guard let memoryMemo = mainView.memoTextField.text, memoryMemo != "" else {
            makeToastMessage(errorType: .noneInputText)
            return
        }
        guard let _ = inputData.address else {
            makeToastMessage(errorType: .noneInputText)
            return
        }
        
        inputData.title = memoryTitle
        inputData.memo = memoryMemo
        RealmManager.shared.writeRecord(data: inputData)
        
        self.navigationController?.popViewController(animated: true)
    }
}


extension WriteViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        images = []
        
        
        results.forEach { result in
            print(result)
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


extension WriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, PassLocation{
    func passingLocation(addressData: Document) {
        
        guard let lat = Double(addressData.x), let long = Double(addressData.y) else {
            self.makeToastMessage(errorType: .network)
            return
        }
        
        let address = AddressData(addressName: addressData.addressName, lat: lat, long: long, placeName: addressData.placeName)
        
        inputData.address = address
        
        self.mainView.locationTextField.text = self.inputData.address?.placeName
    }
    
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
