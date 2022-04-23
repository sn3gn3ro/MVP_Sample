//
//  NotificationSettingsMainCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import UIKit

protocol NotificationSettingsMainCellDelegate: AnyObject {
    func didPressedBackButton()
}


class NotificationSettingsMainCell: UITableViewCell {
    
    let backButtonView = SquareRoundButtonView(type: .backArrow)
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    weak var delegate: NotificationSettingsMainCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setИackButtonView()
        setTitleLabel()
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

    
    //MARK: - Private
    
    private func setИackButtonView() {
        contentView.addSubview(backButtonView)
        backButtonView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
        }
        backButtonView.buttonPressed = {
            self.delegate?.didPressedBackButton()
        }
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButtonView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(38)
            make.bottom.equalToSuperview().offset(-20)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.text = CommonString.notificationsSetting
    }
}


