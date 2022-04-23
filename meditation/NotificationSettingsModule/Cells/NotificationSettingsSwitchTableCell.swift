//
//  NotificationSettingsSwitchTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import UIKit

protocol NotificationSettingsSwitchTableCellDelegate: AnyObject {
    func didChangeSwitch(type: NotificationSettingsSwitchTableCell.NotificationType, isOn: Bool)
}


class NotificationSettingsSwitchTableCell: UITableViewCell {
    
    enum NotificationType {
        case common
        case aboutNewLessons
        case aboutNewOffers
        
        func name() -> String{
            switch self {
                case .common:
                    return CommonString.common
                case .aboutNewLessons:
                    return CommonString.aboutNewLessons
                case .aboutNewOffers:
                    return CommonString.aboutNewOffers
            }
        }
    }
   
    let titleLabel = UILabel()
    let switchView = UISwitch()
    let underLineView = UIView()
    
    var notificationType = NotificationType.common
    
    weak var delegate: NotificationSettingsSwitchTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setTitleLabel()
        setSwitchView()
        setUnderLineView()
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

    func setData(type: NotificationType, isOn: Bool) {
        switchView.isOn = isOn
        notificationType = type
        titleLabel.text = notificationType.name()
    }
    
    //MARK: - Private
    
    @objc private func switchAction() {
        delegate?.didChangeSwitch(type: notificationType, isOn: switchView.isOn)
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
//            make.height.equalTo(38)
            make.bottom.equalToSuperview().offset(-17)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 16)
        titleLabel.textColor = UIColor.white
        
    }
    
    private func setSwitchView() {
        contentView.addSubview(switchView)
        switchView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(31)
        }
        switchView.onTintColor = UIColor.Main.borderViolet
        switchView.addTarget(self, action: #selector(switchAction), for: .valueChanged)
    }
    
    private func setUnderLineView() {
        contentView.addSubview(underLineView)
        underLineView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
        underLineView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
    
    
}



