//
//  SubscriptionFullWidthSmallImageTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 01.02.2022.
//

import UIKit

protocol SubscriptionFullWidthSmallImageTableCellDelegate: AnyObject {
    func didSelectSubscriptionSmallImage()
}

class SubscriptionFullWidthSmallImageTableCell: UITableViewCell {
    
    let backView = UIView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let priceLabel = UILabel()
    let iconImageView = UIImageView()
    let button = UIButton()
    
    weak var delegate: SubscriptionFullWidthSmallImageTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = UIColor.clear
        
        setBackView()
        setTitleLabel()
        setSubtitleLabel()
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
    
    func setData() {
        titleLabel.text = "Пробный период - 1 день"
        subtitleLabel.text = "Вы можете просмотреть всё приложение и познакомиться со всеми его функциями."
        priceLabel.text = "0 ₽"
        iconImageView.image = UIImage(named: "subscriptionSmallImage")
    }
    
    //MARK: - Private
    
    @objc private func buttonAction() {
        delegate?.didSelectSubscriptionSmallImage()
    }
    
    private func setBackView() {
        contentView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        backView.backgroundColor = UIColor.Main.darkViolet
        backView.layer.cornerRadius = 16
        backView.layer.masksToBounds = true
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
    
    private func setPriceLabel() {
        backView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(6)
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
            make.bottom.equalToSuperview().offset(-6)
            make.right.equalToSuperview().offset(-6)
            make.width.equalTo(48)
            make.height.equalTo(67)
        }
        iconImageView.layer.masksToBounds = true
    }
    
    private func setButton() {
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        button.backgroundColor = UIColor.Main.darkViolet.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

