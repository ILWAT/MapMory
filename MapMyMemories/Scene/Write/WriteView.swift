//
//  WriteView.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/01.
//

import UIKit

enum collectionViewType: Int{
    case image = 0
    case emotion
    
    var getViewType: Int{
        switch self {
        case .image:
            return self.rawValue
        case .emotion:
            return self.rawValue
        }
    }
}

final class WriteView: BaseView, UIScrollViewDelegate{
    //MARK: - Properties
    
    let scrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .mainBackgroundColor
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView = {
        let view = UIView()
        view.backgroundColor = .mainBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let imageLabel = {
        let label = UILabel()
        label.text = "사진"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let locationLabel = {
        let label = UILabel()
        label.text = "위치"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let emotionLabel = {
        let label = UILabel()
        label.text = "감정"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let memoLabel = {
        let label = UILabel()
        label.text = "내용"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let tagLabel = {
        let label = UILabel()
        label.text = "사진"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    
    lazy var imageCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.setCollectionViewLayout())
        view.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        view.tag = collectionViewType.image.getViewType
        return view
    }()
    
    
    
    let locationTextField = {
        let view = UILabel()
        view.text = "위치를 지정해주세요"
        return view
    }()
    
    let locationSearchButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "magnifyingglass")
        config.baseForegroundColor = .mainTintColor
        button.configuration = config
        return button
    }()
    
    
    lazy var dateButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer ({ incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.black
            outgoing.font = UIFont.boldSystemFont(ofSize: 20)
            return outgoing
        })
        let date = Date()
        config.baseBackgroundColor = .mainTintColor
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.placeholder = "추억의 제목을 입력해주세요!"
        return view
    }()
    
    let memoTextField = {
        let view = UITextView()
        view.text = ""
        return view
    }()
    
    //MARK: - Configure
    override func configure() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews([imageLabel, locationLabel, dateLabel, titleLabel, emotionLabel, memoLabel, tagLabel])
        contentView.addSubViews([imageCollectionView, locationTextField, locationSearchButton, dateButton, titleTextField, memoTextField])
//        scrollView.delegate = self
    }
    
    //MARK: - SetConstraints
    override func setConstraints() {
        let topDefaultSpace = 15
        let leadingDefaultSpace = 10
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        imageLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(leadingDefaultSpace)
            make.trailing.lessThanOrEqualToSuperview().inset(leadingDefaultSpace)
        }
//        imageView.snp.makeConstraints { make in
//            make.leading.equalTo(imageLabel.snp.leading)
//            make.top.equalTo(imageLabel.snp.bottom).offset(topDefaultSpace)
//            make.size.equalTo(self.snp.width).multipliedBy(0.3)
//        }
//        addImageButton.snp.makeConstraints { make in
//            make.leading.equalTo(imageView.snp.trailing).offset(leadingDefaultSpace)
//            make.top.bottom.equalTo(imageView)
//            make.width.equalTo(addImageButton.snp.height)
//        }
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(imageLabel.snp.bottom).offset(topDefaultSpace)
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(topDefaultSpace)
            make.leading.equalTo(imageLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(leadingDefaultSpace)
        }
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(topDefaultSpace)
            make.leading.trailing.equalToSuperview().inset(leadingDefaultSpace)
            make.height.equalTo(50)
        }
        locationSearchButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(locationTextField)
            make.width.equalTo(locationTextField.snp.height)
            make.leading.equalTo(locationTextField.snp.trailing).offset(leadingDefaultSpace)
            make.trailing.equalToSuperview().inset(leadingDefaultSpace)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(topDefaultSpace)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(leadingDefaultSpace)
            make.trailing.lessThanOrEqualToSuperview().inset(leadingDefaultSpace)
        }
        dateButton.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(topDefaultSpace)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(topDefaultSpace)
            make.leading.equalTo(dateLabel.snp.leading)
            make.trailing.lessThanOrEqualToSuperview().inset(leadingDefaultSpace)
        }
        titleTextField.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(topDefaultSpace)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(leadingDefaultSpace)
        }
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(topDefaultSpace)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(leadingDefaultSpace)
        }
        memoTextField.snp.makeConstraints { make in
            make.leading.equalTo(memoLabel)
            make.top.equalTo(memoLabel.snp.bottom).offset(topDefaultSpace)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(leadingDefaultSpace)
            make.height.equalTo(200)
        }
        emotionLabel.snp.makeConstraints { make in
            make.top.equalTo(memoTextField.snp.bottom).offset(topDefaultSpace)
            make.leading.equalTo(memoLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(leadingDefaultSpace)
            make.bottom.equalToSuperview().inset(topDefaultSpace)
        }
        
    }
    
    
    //MARK: - Helper
    
    func setCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(10)
        let size = 100
        layout.itemSize = CGSize(width: size, height: size)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        return layout
    }
}
