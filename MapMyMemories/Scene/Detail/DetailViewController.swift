//
//  DetailViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/19/23.
//

import UIKit

final class DetailViewController: BaseViewController{
    //MARK: - Properties
    private let mainView = DetailView()
    
    private var data: Memory = Memory()
    private var memoryIndex: Int = 0
    private var addressPK: String = ""
    
    let viewModel = ViewingImageCollectionViewModel()
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    deinit {
        print("DetailView Deinit")
    }
    
    //MARK: - configure
    override func configure() {
        [mainView.imageCollectionView, mainView.emotionCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        mainView.imageRatioControl.addTarget(self, action: #selector(changedImageContentMode), for: .valueChanged)
    }
    
    //MARK: - setNavigation
    override func setNavigation() {
        self.title = "내 추억 보기"
        
        let deleteBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(tappedDeleteBarButtonItem))
        deleteBarButtonItem.tintColor = .label
        let modifyBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(tappedModifyBarButtonItem))
        modifyBarButtonItem.tintColor = .label
        
        self.navigationItem.setRightBarButtonItems([deleteBarButtonItem], animated: true)
    }
    
    func setMemoryData(data: Memory, memoryIndex: Int, addressPrimaryKey: String){
        self.data = data
        self.memoryIndex = memoryIndex
        self.addressPK = addressPrimaryKey
        mainView.setUIData(data: data)
    }
    
    //MARK: - Action
    
    @objc func changedImageContentMode(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 1:
            viewModel.imageContentMode.value = .scaleAspectFit
        default:
            viewModel.imageContentMode.value = .scaleAspectFill
        }
    }
    
    @objc func tappedDeleteBarButtonItem(_ sender: UIBarButtonItem){
        let alert = UIAlertController(title: "추억 삭제", message: "추억을 정말로 삭제하시겠습니까?\n한번 삭제한 추억은 다시 되돌릴 수 없습니다!!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .default) { action in
            print("ok")
            guard let addressData = RealmManager.shared.readSpecificRecord(type: AddressData.self, pk: self.addressPK) else {return}
            guard RealmManager.shared.deleteEmbeddedListRecord(address: addressData, memoryIndex: self.memoryIndex) else {
                self.makeToastMessage(errorType: .failedDeleteRealm)
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        [ok, cancel].forEach { action in
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
    
    @objc func tappedModifyBarButtonItem(_ sender: UIBarButtonItem) {
        let modifyVC = WriteViewController()
        self.navigationController?.pushViewController(modifyVC, animated: true)
        modifyVC.viewModel.setViewModel(data: data)
    }
    
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK: - UICOllectionViewDelegate, DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case CollectionViewTagType.image.rawValue:
            print(data.imageURL.count)
            return data.imageURL.count
        case CollectionViewTagType.emotion.rawValue:
            return data.emotion.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        case CollectionViewTagType.image.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewingImageCollectionViewCell.identifier, for: indexPath) as? ViewingImageCollectionViewCell else {return UICollectionViewCell()}
            
            let imageName = data.imageURL[indexPath.item]
            cell.setImage(imageName: imageName, contentMode: viewModel.imageContentMode.value)
            print(imageName)
            
            mainView.imageRatioControl.addTarget(cell.self, action: #selector(cell.changeImageContentMode), for: .valueChanged)
            
            return cell
        case CollectionViewTagType.emotion.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewingEmotionCollectionViewCell.identifier, for: indexPath) as? ViewingEmotionCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setLabel(text: data.emotion[indexPath.item].emotion)
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenWidth = CGFloat(UserDefaults.standard.float(forKey: UserDefaultsIdentifier.screenWidth.rawValue))
        if screenWidth != 0{
            mainView.pageControl.currentPage = Int(scrollView.contentOffset.x/screenWidth)
        }
        
    }
    
    
}
