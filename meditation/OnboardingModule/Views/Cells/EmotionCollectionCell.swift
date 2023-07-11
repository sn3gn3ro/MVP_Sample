//
//  EmotionCollectionCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 13.01.2022.
//

import UIKit

class EmotionCollectionCell: UICollectionViewCell {
    
    let blurView = UIImageView()
    let typeImageView = UIImageView()
    let typeLabel = UILabel()
        
    static var identifier: String = "EmotionCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBlurView()
        setTypeImageView()
        setTypeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String, isSelect: Bool, image: UIImage?) {
        typeLabel.text = title
        blurView.isHidden = !isSelect
        typeLabel.textColor =  isSelect ? UIColor.white : UIColor.Main.grayViolet
        typeImageView.image = image
    }

    //MARK: - Private
    
    private func setBlurView() {
        addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(90)
        }
        blurView.image = UIImage(named: "activeBlur")
    }
    
    private func setTypeImageView() {
        addSubview(typeImageView)
        typeImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(blurView.snp.centerY)
            make.centerX.equalTo(blurView.snp.centerX)
            make.height.equalTo(64)
        }
        typeImageView.contentMode = .scaleAspectFit
    }

    private func setTypeLabel() {
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeImageView.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(14)
        }
        typeLabel.textAlignment = .center
        typeLabel.numberOfLines = 1
        typeLabel.font = UIFont.Basic.latoNormal(size: 14)
    }
}

