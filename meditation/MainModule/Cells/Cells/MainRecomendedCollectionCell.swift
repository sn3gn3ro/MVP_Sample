//
//  MainRecomendedCollectionCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 19.01.2022.
//

import UIKit

class MainRecomendedCollectionCell: UICollectionViewCell {
    
    let backImageView = UIImageView()
    let lessonsCountLabel = UILabel()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackImageView()
        setLessonsCountLabel()
        setTitleLabel()
        setSubTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Actions
    
    func setData(image: UIImage, lessonCount: Int, title: String, subtitle: String) {
        backImageView.image = image
        lessonsCountLabel.text = "\(lessonCount) \(CommonString.audiolessons)"
        titleLabel.text = title
        subTitleLabel.text = subtitle
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        backImageView.clipsToBounds = true
        backImageView.layer.cornerRadius = 17
    }
    
    private func setLessonsCountLabel() {
        contentView.addSubview(lessonsCountLabel)
        lessonsCountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(backImageView.snp.bottom).offset(-13)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(16)
        }
        lessonsCountLabel.textAlignment = .left
        lessonsCountLabel.font = UIFont.Basic.latoNormal(size: 12)
        lessonsCountLabel.textColor = UIColor.Main.textGray
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backImageView.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(17)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoBold(size: 14)
        titleLabel.textColor = UIColor.white
    }
    
    private func setSubTitleLabel() {
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.height.equalTo(14)
            make.bottom.equalToSuperview()
        }
        subTitleLabel.numberOfLines = 1
        subTitleLabel.textAlignment = .left
        subTitleLabel.font = UIFont.Basic.latoNormal(size: 12)
        subTitleLabel.textColor = UIColor.Main.textGray
    }
}



