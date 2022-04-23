//
//  ElementInCategoryCollectionCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.01.2022.
//

import UIKit
import Hero

class ElementInCategoryCollectionCell: UICollectionViewCell {
    
    let backImageView = UIImageView()
    var blurEffectView =  UIVisualEffectView()
    let lessonNameLabel = UILabel()
    let statusImageView  = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackImageView()
        setBlurEffectView()
        setLessonNameLabel()
        setStatusImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Actions
    
    func setData(image: UIImage, lessonName: String) {
        backImageView.image = image
        lessonNameLabel.text = lessonName
        statusImageView.image = UIImage(named: "playPurple")
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
//            make.height.equalTo(146)
            make.bottom.equalToSuperview()
        }
        backImageView.clipsToBounds = true
        backImageView.layer.cornerRadius = 16
        backImageView.contentMode = .scaleAspectFill
       
    }
    
    private func setBlurEffectView() {
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style:.systemThinMaterialDark))
        contentView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
        blurEffectView.alpha = 0.4
    }
    
    private func setLessonNameLabel() {
        contentView.addSubview(lessonNameLabel)
        lessonNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(backImageView.snp.bottom).offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
//            make.height.equalTo(16)
        }
        lessonNameLabel.textAlignment = .left
        lessonNameLabel.font = UIFont.Basic.latoNormal(size: 14)
        lessonNameLabel.textColor = UIColor.white
        lessonNameLabel.numberOfLines = 0
    }
    
    private func setStatusImageView() {
        contentView.addSubview(statusImageView)
        statusImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(24)
        }
       
    }
    
}




