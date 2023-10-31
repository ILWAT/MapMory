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
        view.tag = CollectionViewTagType.image.rawValue
        view.register(ViewingImageCollectionViewCell.self, forCellWithReuseIdentifier: ViewingImageCollectionViewCell.identifier)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
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
        view.register(ViewingEmotionCollectionViewCell.self, forCellWithReuseIdentifier: ViewingEmotionCollectionViewCell.identifier)
        view.showsVerticalScrollIndicator = false
        view.tag = CollectionViewTagType.emotion.rawValue
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

    let imageRatioControl = {
        let view = UISegmentedControl()
        view.insertSegment(with: UIImage(systemName: "rectangle.and.arrow.up.right.and.arrow.down.left"), at: 0, animated: true)
        view.insertSegment(with: UIImage(systemName: "rectangle.and.arrow.up.right.and.arrow.down.left.slash"), at: 1, animated: true)
        view.selectedSegmentIndex = 0
        return view
    }()
    
    //MARK: - configure
    override func configure() {
        self.addSubViews([imageCollectionView, pageControl, subScrollView])
        subScrollView.addSubview(scrollContentView)
        scrollContentView.addSubViews([titleLabel, dateLabel, divideView, memoTextView, emotionCollectionView, imageRatioControl])
    }
    
    
    //MARK: - SetConstraints
    override func setConstraints() {
        let defaultSpacing = 10
        imageCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
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
        imageRatioControl.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(defaultSpacing)
            make.top.equalTo(titleLabel)
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
            make.top.equalTo(memoTextView.snp.bottom).offset(defaultSpacing)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.bottom.equalToSuperview().inset(defaultSpacing)
        }
        
        
    }
    
    //MARK: - Helper
    private func setEmotionCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let defaultSpacing: CGFloat = 10
        layout.sectionInset = UIEdgeInsets(top: defaultSpacing, left: defaultSpacing, bottom: defaultSpacing, right: defaultSpacing)
        layout.minimumInteritemSpacing = defaultSpacing
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    private func setImageCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let defaultSpacing: CGFloat = 10
        
        let screenWidth: CGFloat = CGFloat(UserDefaults.standard.float(forKey: UserDefaultsIdentifier.screenWidth.rawValue))
        let screenHeight: CGFloat = CGFloat(UserDefaults.standard.float(forKey: UserDefaultsIdentifier.screenHeight.rawValue))
        
        let itemWidth: CGFloat
        let itemHeight: CGFloat
        
        if screenWidth != 0, screenHeight != 0 {
            itemWidth = screenWidth
            itemHeight = screenHeight * 0.2
        } else {
            itemWidth = UIScreen.main.bounds.width
            itemHeight = UIScreen.main.bounds.height * 0.2
        }
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    private func setPageController(totalPage: Int){
        pageControl.numberOfPages = totalPage
    }
    
    func setUIData(data: Memory){
        titleLabel.text = data.title
        memoTextView.text = data.memo
        
        //DateFormatter
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd. hh:mm"
        dateLabel.text = formatter.string(from: data.memoryDate)
        
        setPageController(totalPage: data.imageURL.count)
    }
    
}
