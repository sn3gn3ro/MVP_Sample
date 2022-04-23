//
//  HashtagCollectionCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 02.02.2022.
//

import UIKit

class HashtagCollectionCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        
        setTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Actions
    
    func setData(text: String) {
        contentView.backgroundColor = UIColor.Main.grayViolet
        titleLabel.text = text
    }
    
    //MARK: - Private
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(14)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoBold(size: 12)
        titleLabel.textColor = UIColor.white
    }
}




