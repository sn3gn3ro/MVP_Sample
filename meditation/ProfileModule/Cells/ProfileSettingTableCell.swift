//
//  ProfileSettingTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit
import SkeletonView

class ProfileSettingTableCell: UITableViewCell {
    
    enum Setting {
        case favoritesLessons
        case subscription
        case notifications
        case review
        
        func image() -> UIImage {
            switch self {
                case .favoritesLessons:
                    return UIImage(named: "heart") ?? UIImage()
                case .subscription:
                    return UIImage(named: "star") ?? UIImage()
                case .notifications:
                    return UIImage(named: "bell") ?? UIImage()
                case .review:
                    return UIImage(named: "text") ?? UIImage()
            }
        }
        
        func name() -> String {
            switch self {
                case .favoritesLessons:
                    return CommonString.favoritesLessons
                case .subscription:
                    return CommonString.subscriptionSetting
                case .notifications:
                    return CommonString.notificationsSetting
                case .review:
                    return CommonString.leaveReview
            }
        }
    }
    
    let iconImageView = UIImageView()
    let settingNameLabel = UILabel()
    let arrowImageView = UIImageView()
    
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        isSkeletonable = true
        setSettingNameLabel()
        setIconImageView()
        setArrowImageView()
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
        arrowImageView.isHidden = true
        setSkeletonableStyle()
    }
    
    func setData(type:Setting) {
        hideSkeleton()
        arrowImageView.isHidden = false
        iconImageView.image = type.image()
        settingNameLabel.text = type.name()
        
    }
    
    
    //MARK: - Private
    
    private func setSettingNameLabel() {
        contentView.addSubview(settingNameLabel)
        settingNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(56)
            make.right.equalToSuperview().offset(-40)
            make.height.greaterThanOrEqualTo(24)
        }
        settingNameLabel.textAlignment = .left
        settingNameLabel.font = UIFont.Basic.latoNormal(size: 18)
        settingNameLabel.textColor = UIColor.white
        settingNameLabel.isSkeletonable = true
        settingNameLabel.linesCornerRadius = 4
        settingNameLabel.skeletonTextLineHeight = SkeletonTextLineHeight.relativeToFont
//        settingNameLabel.lastLineFillPercent = 20
    }
    
    private func setIconImageView() {
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(settingNameLabel.snp.centerY)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
        }
        iconImageView.isSkeletonable = true
        iconImageView.skeletonCornerRadius = 12
    }
    
    private func setArrowImageView() {
        contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(settingNameLabel.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(24)
        }
        arrowImageView.image = UIImage(named: "rightWhiteSmallArrow")
    }
}
