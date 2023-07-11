//
//  SubscriptionOptionCollectionCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 01.02.2022.
//

import UIKit
import SkeletonView

class SubscriptionOptionCollectionCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let discountLabel = UILabel()
    let datePeriodLabel = UILabel()
    let costLabel = UILabel()
    
    static var identifier: String = "SubscriptionOptionCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor.Main.darkViolet
        layer.cornerRadius = 16
        isSkeletonable = true
        skeletonCornerRadius = 16
        
        setTitleLabel()
        setDiscountLabel()
        setDatePeriodLabel()
        setCostLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSkeletone() {
        setSkeletonableStyle()
    }
    
    
    func setData() {
        titleLabel.text = "На три месяца"
        discountLabel.text = "На 15% выгоднее!"
        datePeriodLabel.text = "18.11.21 - 18.02.22"
        costLabel.text = "250 ₽"
    }
    
    //MARK: - Private

    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.height.equalTo(22)
        }
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.Basic.latoNormal(size: 16)
        titleLabel.textColor = UIColor.Main.textGray
    }
    
    private func setDiscountLabel() {
        addSubview(discountLabel)
        discountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.height.equalTo(16)
        }
        discountLabel.textAlignment = .left
        discountLabel.numberOfLines = 1
        discountLabel.font = UIFont.Basic.latoNormal(size: 12)
        discountLabel.textColor = UIColor.Main.borderViolet
    }
    
    private func setDatePeriodLabel() {
        addSubview(datePeriodLabel)
        datePeriodLabel.snp.makeConstraints { (make) in
            make.top.equalTo(discountLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.height.equalTo(16)
        }
        datePeriodLabel.textAlignment = .left
        datePeriodLabel.numberOfLines = 1
        datePeriodLabel.font = UIFont.Basic.latoNormal(size: 12)
        datePeriodLabel.textColor = UIColor.Main.grayViolet
    }
    
    private func setCostLabel() {
        addSubview(costLabel)
        costLabel.snp.makeConstraints { (make) in
            make.top.equalTo(datePeriodLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.height.equalTo(27)
        }
        costLabel.textAlignment = .left
        costLabel.numberOfLines = 1
        costLabel.font = UIFont.Basic.latoNormal(size: 20)
        costLabel.textColor = UIColor.white
    }
}

