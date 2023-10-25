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
    
    private var data: MemoryDB = MemoryDB()
    
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
    }
    
    func setMemoryData(data: MemoryDB){
        self.data = data
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
