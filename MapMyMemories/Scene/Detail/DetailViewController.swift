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
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    //MARK: - configure
    override func configure() {
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
    }
    
    //MARK: - setNavigation
    override func setNavigation() {
        self.title = "내 추억 보기"
    }
    
    func setMemoryData(data: MemoryDB){
        self.data = data
        mainView.setUIData(data: data)
    }
    
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case CollectionViewTagType.image.rawValue:
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
            
            return cell
        case CollectionViewTagType.emotion.rawValue:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewingEmotionCollectinoViewCell.identifier, for: indexPath)
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
        
    }
    
    
}
