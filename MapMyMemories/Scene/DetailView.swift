//
//  DetailView.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/19/23.
//

import UIKit

class DetailView: BaseView{
    //MARK: - Properties
    lazy var imageCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.setImageCollectionViewLayout())
        view.register(ViewingImageCollectionViewCell.self, forCellWithReuseIdentifier: ViewingImageCollectionViewCell.identifier)
        return view
    }()
    
    let subScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .mainBackgroundColor
        view.layer.cornerRadius = 10
        view.backgroundColor = .mainBackgroundColor
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        return view
    }()
    
    let scrollContentView = UIView()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let locationLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }
    
    let memoTextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 15)
        view.isEditable = false
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var emotionCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.setEmotionCollectionViewLayout())
        view.register(ViewingImageCollectionViewCell.self, forCellWithReuseIdentifier: ViewingImageCollectionViewCell.identifier)
        return view
    }()
    
    let pageControl = {
        let controller = UIPageControl(frame: .zero)
        controller.direction = .leftToRight
        return controller
    }()
    
    let divideView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    //MARK: - configure
    override func configure() {
        self.addSubViews([imageCollectionView, pageControl, subScrollView])
        subScrollView.addSubview(scrollContentView)
        scrollContentView.addSubViews([titleLabel, dateLabel, divideView, memoTextView, emotionCollectionView])
    }
    
    
    //MARK: - SetConstraints
    override func setConstraints() {
        let defaultSpacing = 10
        imageCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(imageCollectionView)
            make.centerX.equalTo(imageCollectionView.snp.centerX)
        }
        subScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(imageCollectionView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        scrollContentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(subScrollView.contentLayoutGuide)
            make.width.equalTo(subScrollView.frameLayoutGuide)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(defaultSpacing)
            make.leading.equalToSuperview().inset(defaultSpacing)
            make.trailing.lessThanOrEqualToSuperview().inset(defaultSpacing)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(defaultSpacing)
            make.top.equalTo(titleLabel.snp.bottom).offset(defaultSpacing)
        }
        divideView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(defaultSpacing)
            make.height.equalTo(1)
        }
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(divideView.snp.bottom).offset(defaultSpacing)
            make.horizontalEdges.equalTo(divideView)
            make.height.equalTo(subScrollView.frameLayoutGuide).multipliedBy(0.5)
        }
        emotionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(memoTextView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.bottom.equalToSuperview().inset(defaultSpacing)
        }
        
        
    }
    
    //MARK: - Helper
    func setEmotionCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let defaultSpacing: CGFloat = 10
        layout.sectionInset = UIEdgeInsets(top: defaultSpacing, left: defaultSpacing, bottom: defaultSpacing, right: defaultSpacing)
        layout.minimumInteritemSpacing = defaultSpacing
        
        return layout
    }
    
    func setImageCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let defaultSpacing: CGFloat = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: defaultSpacing, bottom: 0, right: defaultSpacing)
        layout.minimumInteritemSpacing = defaultSpacing
        
        return layout
    }
    
    private func setPageController(totalPage: Int){
        pageControl.numberOfPages = totalPage
    }
    
    func setUIData(data: MemoryDB){
        titleLabel.text = data.title
        memoTextView.text = data.memo
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd"
        dateLabel.text = formatter.string(from: data.date)
        setPageController(totalPage: data.imageURL.count)
    }
    
}
