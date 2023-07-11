//
//  SubscriptionFullWidthBigImageTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 01.02.2022.
//

import UIKit
import SkeletonView

protocol SubscriptionFullWidthBigImageTableCellDelegate: AnyObject {
    func didChooseBigImageSubscription()
}

class SubscriptionFullWidthBigImageTableCell: UITableViewCell {
    
    let backView = UIView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let datePeriodLabel = UILabel()
    let priceLabel = UILabel()
    let iconImageView = UIImageView()
    let button = UIButton()
    
    weak var delegate: SubscriptionFullWidthBigImageTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        isSkeletonable = true
        contentView.isSkeletonable = true
        
        setBackView()
        setTitleLabel()
        setSubtitleLabel()
        setDatePeriodLabel()
        setPriceLabel()
        setIconImageView()
        setButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    //MARK: - Actions
    
    func setSkeleton() {
//        titleLabel.text = ""
//        subtitleLabel.text = ""
//        datePeriodLabel.text = ""
//        priceLabel.text = ""
//        iconImageView.image = UIImage(named: "subscriptionBigImage")
        setSkeletonableStyle()
        backView.setSkeletonableStyle()
    }

    
    func setData() {
        hideSkeleton()
        titleLabel.text = "На месяц"
        subtitleLabel.text = "На 10% выгоднее!"
        datePeriodLabel.text = "18.11.21 - 18.12.21"
        priceLabel.text = "100 ₽"
        iconImageView.image = UIImage(named: "subscriptionBigImage")
    }

    
    //MARK: - Private
    
    @objc private func buttonAction() {
        delegate?.didChooseBigImageSubscription()
    }
    
    private func setBackView() {
        contentView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(145)
        }
        backView.backgroundColor = UIColor.Main.darkViolet
        backView.layer.cornerRadius = 16
        backView.layer.masksToBounds = true
        backView.isSkeletonable = true
        backView.skeletonCornerRadius = 16
    }
   
    private func setTitleLabel() {
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.Basic.latoNormal(size: 18)
        titleLabel.textColor = UIColor.white
    }
    
    private func setSubtitleLabel() {
        backView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.Basic.latoNormal(size: 12)
        subtitleLabel.textColor = UIColor.Main.borderViolet
    }
    
    private func setDatePeriodLabel() {
        backView.addSubview(datePeriodLabel)
        datePeriodLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(13)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        datePeriodLabel.textAlignment = .left
        datePeriodLabel.numberOfLines = 0
        datePeriodLabel.font = UIFont.Basic.latoNormal(size: 12)
        datePeriodLabel.textColor = UIColor.Main.grayViolet
    }
    
    private func setPriceLabel() {
        backView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(datePeriodLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        priceLabel.textAlignment = .left
        priceLabel.numberOfLines = 0
        priceLabel.font = UIFont.Basic.latoNormal(size: 22)
        priceLabel.textColor = UIColor.white
    }
    
    private func setIconImageView() {
        backView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(26)
            make.bottom.equalToSuperview()
            make.width.equalTo(iconImageView.snp.height)
        }
    }
    
    private func setButton() {
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
}

