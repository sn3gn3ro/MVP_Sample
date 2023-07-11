//
//  EmotionsWorkView.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit
import SnapKit

class EmotionsWorkView: UIView {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let backButtonView =  SimpleTextButtonView(type: .bordered, text: CommonString.back)
    private let furtherButtonView =  SimpleTextButtonView(type: .unactive, text: CommonString.further)


    var didPressedFurther: (([QuestionsListDataImageModel]?,Int, Bool)->())?
    var didPressedBack: (()->())?
    var selectedVariants = [QuestionsListDataImageModel]()
    
    var data: QuestionsListDataModel?
    var isLast = false
    var index = 0
    var imagesDict = [String:UIImage]()
    
    init() {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        UITextField.appearance().tintColor = UIColor.Main.borderViolet
        
        setTitleLabel()
        setSubtitleLabel()
        setCollectionView()
        setBackButton()
        setFurtherButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setData(data:QuestionsListDataModel, isLast: Bool, index: Int) {
        self.data = data
        self.isLast = isLast
        self.index = index
        getImages()
        titleLabel.text = data.name
        subtitleLabel.text = data.description
        collectionView.reloadData()
    }
    
    func getImages() {
        guard let images = data?.images else { return }
        for (index,element) in images.enumerated() {
            guard let imageUrl = element.image else { return }
            NetworkManager.getImage(imageUrl: imageUrl) { [weak self] image in
                self?.imagesDict[imageUrl] = image
                self?.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
        }
    }
    
    // MARK: - Private
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(76)
        }
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.Basic.latoBold(size: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.text = CommonString.emotionsWorkTitle
    }
    
    private func setSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(38)
        }
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.Basic.latoNormal(size: 14)
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.text = CommonString.emotionsWorkSubtitle
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(77)
            make.height.equalTo(220)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(EmotionCollectionCell.self, forCellWithReuseIdentifier: EmotionCollectionCell.identifier)
    }
    
    private func setBackButton() {
        addSubview(backButtonView)
        backButtonView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(snp.centerX).offset(-7)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-60)
        }
        backButtonView.buttonAction = {
            self.didPressedBack?()
        }
    }
    
    private func setFurtherButton() {
        addSubview(furtherButtonView)
        furtherButtonView.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(snp.centerX).offset(7)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-60)
        }
        furtherButtonView.buttonAction = {
            self.didPressedFurther?(self.selectedVariants, self.index, self.isLast)
        }
    }
}


//MARK: - UICollectionViewDelegate

extension EmotionsWorkView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let images = data?.images else { return }
        if selectedVariants.contains(where: {$0.id == images[indexPath.row].id}) {
            selectedVariants.removeAll(where: {$0.id == images[indexPath.row].id})
        } else {
            selectedVariants.append(images[indexPath.row])
        }
        
        if selectedVariants.isEmpty {
            furtherButtonView.setStyle(type: .unactive)
        } else {
            furtherButtonView.setStyle(type: .normal)
        }
        collectionView.reloadItems(at: [indexPath])
    }
}

//MARK: - UICollectionViewDataSource

extension EmotionsWorkView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCollectionCell.identifier, for: indexPath) as! EmotionCollectionCell
        guard let image = data?.images?[indexPath.row] else { return cell }
        let isSelect = selectedVariants.first(where: {$0.id == image.id})
        cell.setData(title: image.name ?? "",
                     isSelect: isSelect != nil,
                     image: imagesDict[image.image ?? ""])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension EmotionsWorkView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 100
        let widht: CGFloat = 90
        
        return CGSize(width: widht, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
