//
//  SubscriptionMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 01.02.2022.
//

import UIKit
import SkeletonView

protocol SubscriptionMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
}


class SubscriptionMainTableCell: UITableViewCell {
    
    let backButtonView = SquareRoundButtonView(type: .backArrow)
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    weak var delegate: SubscriptionMainTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        isSkeletonable = true
//        contentView.isSkeletonable = true
        
        setBackButtonView()
        setTitleLabel()
        setSubtitleLabel()
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
        backButtonView.setSkeletonableStyle()
        titleLabel.setSkeletonableStyle()
        subtitleLabel.setSkeletonableStyle()
    }
    
    func setData() {
        hideSkeleton()
        subtitleLabel.text = "Подписка на год истекает через 12 месцев"
    }

    
    //MARK: - Private
    
    private func setBackButtonView() {
        contentView.addSubview(backButtonView)
        backButtonView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
        }
        backButtonView.buttonPressed = {
            self.delegate?.didPressedBackButton()
        }
        backButtonView.isSkeletonable = true
        backButtonView.skeletonCornerRadius = 12
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButtonView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.Basic.latoNormal(size: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.text = CommonString.subscription
        titleLabel.isSkeletonable = true
        titleLabel.linesCornerRadius = 4
        titleLabel.skeletonTextLineHeight = SkeletonTextLineHeight.relativeToFont
        titleLabel.lastLineFillPercent = 50
    }
    
    private func setSubtitleLabel() {
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(15)
        }
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.Basic.latoNormal(size: 14)
        subtitleLabel.textColor = UIColor.Main.textGray
        subtitleLabel.text = "Подписка на год истекает через 12 месцев"
        subtitleLabel.isSkeletonable = true
        subtitleLabel.linesCornerRadius = 4
        subtitleLabel.skeletonTextLineHeight = SkeletonTextLineHeight.relativeToFont
    }
    
    
}



