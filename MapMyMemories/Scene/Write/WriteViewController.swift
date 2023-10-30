//
//  WriteViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/01.
//

import UIKit
import PhotosUI
import EmojiPicker

final class WriteViewController: BaseViewController{
    
    let mainView = WriteView()
    
    let inputData = MemoryDB()
    
    let viewModel = WriteViewModel()

    
    var images: [UIImage] = []{
        didSet{
            mainView.imageCollectionView.reloadData()
        }
    }
    
    var emotion: [String] = []{
        didSet{
            mainView.emotionCollectionView.reloadData()
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
        mainView.emotionCollectionView.delegate = self
        mainView.emotionCollectionView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedGesture))
        gesture.numberOfTapsRequired = 1
        gesture.isEnabled = true
        mainView.scrollView.addGestureRecognizer(gesture)
        
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
        configuration.selectionLimit = 5
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
//        let selectLocation = UIAlertAction(title: "위치 지정하기", style: .default) { action in
//            self.makeToastMessage("아직 준비중인 서비스입니다.")
//        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        [searchLocation, cancel].forEach { element in
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
    
    @objc func tappedAddEmotionBtn(_ sender: UIButton){
        let viewController = EmojiPickerViewController()
        viewController.delegate = self
        viewController.sourceView = sender
        viewController.arrowDirection = .down
        viewController.isDismissedAfterChoosing = true
        present(viewController, animated: true)
    }
    
    @objc func tappedGesture(_ sender: UITapGestureRecognizer){
        self.mainView.scrollView.endEditing(true)
    }
    
    //MARK: - Helper
    
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
        inputData.memoryDate = viewModel.date.value
        for element in emotion{
            inputData.emotion.append(EmotionDB(emotion: element, emotionDate: Date()))
        }
        
        var imageCount = 0
        images.forEach { image in
            DocumentFileManager.shared.saveImageToDocument(fileName: ImageFileNameExtension.jpeg(fileName: "\(self.inputData._id)_\(imageCount)"), image: image)
            inputData.imageURL.insert("\(self.inputData._id)_\(imageCount)")
            imageCount += 1
        }
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
        print(images)
    }
    
    
}


extension WriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, PassLocation, EmojiPickerDelegate{
    //MARK: - CollectionViewDelegate & DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case CollectionViewTagType.image.rawValue:
            return images.count + 1
            
        case CollectionViewTagType.emotion.rawValue:
            return emotion.count + 1
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        case CollectionViewTagType.image.rawValue:
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
            
        case CollectionViewTagType.emotion.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCollectionViewCell.identifier, for: indexPath) as? EmotionCollectionViewCell else { return UICollectionViewCell() }
            
            cell.addEmotionButton.addTarget(self, action: #selector(tappedAddEmotionBtn), for: .touchUpInside)
            
            if indexPath.item == 0{
                cell.addEmotionButton.isHidden = false
                cell.emotionLabel.text = nil
                cell.deleteButton.isHidden = true
            } else {
                cell.emotionLabel.text = emotion[indexPath.item-1]
                cell.addEmotionButton.isHidden = true
                cell.deleteButton.isHidden = false
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag{
        case CollectionViewTagType.image.rawValue:
            break
            
        case CollectionViewTagType.emotion.rawValue:
            break
            
        default:
            break
        }
    }
    
    //MARK: - SearchControllerDelegate
    func passingLocation(addressData: Document) {
        
        guard let lat = Double(addressData.y), let long = Double(addressData.x) else {
            self.makeToastMessage(errorType: .network)
            return
        }
        
        let address = AddressData(addressName: addressData.addressName, lat: lat, long: long, placeName: addressData.placeName)
        
        inputData.address = address
        
        self.mainView.locationTextField.text = self.inputData.address?.placeName
        
    }
    
    //MARK: - EmojiPickerDelegate
    func didGetEmoji(emoji: String) {
        self.emotion.append(emoji)
    }
    
}
