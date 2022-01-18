//
//  EmotionsWorkView.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit
import SnapKit

class EmotionsWorkView: UIView {
    
    enum Emotion {
        case anxiety
        case anger
        case jealousy
        case gilt
        case fear
        case loneliness
        case shame
        
        func name() -> String {
            switch self {
                case .anxiety:
                    return CommonString.anxiety
                case .anger:
                    return CommonString.anger
                case .jealousy:
                    return CommonString.jealousy
                case .gilt:
                    return CommonString.gilt
                case .fear:
                    return CommonString.fear
                case .loneliness:
                    return CommonString.loneliness
                case .shame:
                    return CommonString.shame
            }
        }
        
        func image() -> UIImage {
            switch self {
                case .anxiety:
                    return UIImage(named: "anxiety") ?? UIImage()
                case .anger:
                    return UIImage(named: "anger") ?? UIImage()
                case .jealousy:
                    return UIImage(named: "jealousy") ?? UIImage()
                case .gilt:
                    return UIImage(named: "gilt") ?? UIImage()
                case .fear:
                    return UIImage(named: "fear") ?? UIImage()
                case .loneliness:
                    return UIImage(named: "loneliness") ?? UIImage()
                case .shame:
                    return UIImage(named: "shame") ?? UIImage()
            }
        }
    }
    
    struct EmotionModel {
        var emotion: Emotion
        var isSelect: Bool
    }
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let backButtonView =  SimpleTextButtonView(type: .bordered, text: CommonString.back)
    private let furtherButtonView =  SimpleTextButtonView(type: .unactive, text: CommonString.further)


    var didSelectEmotions:(([EmotionModel])->())?
    var didPressedFurther: (([EmotionModel])->())?
    var didPressedBack: (()->())?
    
    var emotions: [EmotionModel] = [EmotionModel(emotion: .anxiety, isSelect: false),
                                    EmotionModel(emotion: .anger, isSelect: false),
                                    EmotionModel(emotion: .jealousy, isSelect: false),
                                    EmotionModel(emotion: .gilt, isSelect: false),
                                    EmotionModel(emotion: .fear, isSelect: false),
                                    EmotionModel(emotion: .loneliness, isSelect: false),
                                    EmotionModel(emotion: .shame, isSelect: false)]
    
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
//        collectionView.contentMode = .center
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(EmotionCollectionCell.self, forCellWithReuseIdentifier: EmotionCollectionCell.identifier)
    }
    
    private func setBackButton() {
        addSubview(backButtonView)
        backButtonView.snp.remakeConstraints { (make) in
//            make.top.equalTo(collectionView.snp.bottom).offset(131)
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
//            make.top.equalTo(collectionView.snp.bottom).offset(131)
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(snp.centerX).offset(7)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-60)
        }
        furtherButtonView.buttonAction = {
            self.didPressedFurther?(self.emotions.filter({$0.isSelect == true}))
        }
    }
}


//MARK: - UICollectionViewDelegate

extension EmotionsWorkView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        emotions[indexPath.row].isSelect = !emotions[indexPath.row].isSelect
        emotions.filter({$0.isSelect == true}).isEmpty ? furtherButtonView.setStyle(type: .unactive) : furtherButtonView.setStyle(type: .normal)
        collectionView.reloadItems(at: [indexPath])
    }
}

//MARK: - UICollectionViewDataSource

extension EmotionsWorkView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCollectionCell.identifier, for: indexPath) as! EmotionCollectionCell
        cell.setData(emotionModel: emotions[indexPath.row])
        
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
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = 100 * emotions.count
////        let totalSpacingWidth = CellSpacing * (CellCount - 1)
//
//        let leftInset = (CGFloat(totalCellWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
    
}
