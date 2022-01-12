//
//  LogInPhoneMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import UIKit

protocol LogInPhoneMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
    func didPressedSendCode()
    func didPressedEnter()
    func didEndEnterPhone(phone: String)
}

class LogInPhoneMainTableCell: UITableViewCell {
    
    let starsBackImageView = UIImageView()
    let meditationLogoImageView = UIImageView()
    let backArrowImageView = UIImageView()
    let backArrowButton = UIButton()
    let phoneView = DataEnterView(type: .phone)
    let sendCodeButtonView = SimpleTextButtonView(type: .unactive, text: CommonString.sendCode)
//    let allreadyHaveAccountLabel = UILabel()
//    let enterButton = UIButton()
  
    weak var delegate: LogInPhoneMainTableCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setStarsBackImageView()
        setMeditationLogoImageView()
        setBackArrowImageView()
        setBackArrowButton()
        setPhoneView()
        setSendCodeButtonView()
//        setAllreadyHaveAccountLabel()
//        setEnterButton()
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
    
    @objc private func backButtonAction() {
        delegate?.didPressedBackButton()
    }
    
    @objc private func enterButtonAction() {
        if phoneView.isDataValidate {
            delegate?.didPressedEnter()
        }
    }
    
    //MARK: - Private
    
    private func setStarsBackImageView() {
        contentView.addSubview(starsBackImageView)
        starsBackImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(356)
        }
        starsBackImageView.image = UIImage(named: "stars")
    }
    
    private func setMeditationLogoImageView() {
        contentView.addSubview(meditationLogoImageView)
        meditationLogoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(61)
            make.centerX.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(160)
        }
        meditationLogoImageView.image = UIImage(named: "meditationLogo")
    }
    
    private func setBackArrowImageView() {
        contentView.addSubview(backArrowImageView)
        backArrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(meditationLogoImageView.snp.centerY)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(22)
            make.width.equalTo(13)
        }
        backArrowImageView.image = UIImage(named: "leftWhiteBoldArrow")
    }
    
    private func setBackArrowButton() {
        contentView.addSubview(backArrowButton)
        backArrowButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(backArrowImageView.snp.centerY)
            make.centerX.equalTo(backArrowImageView.snp.centerX)
            make.height.width.equalTo(50)
        }
        backArrowButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    private func setPhoneView() {
        contentView.addSubview(phoneView)
        phoneView.snp.makeConstraints { (make) in
            make.top.equalTo(meditationLogoImageView.snp.bottom).offset(57)
            make.centerX.equalToSuperview()
        }
        
        phoneView.dataEndEditing = { data in
            if self.phoneView.isDataValidate {
                self.sendCodeButtonView.setStyle(type: .normal)
            } else {
                self.sendCodeButtonView.setStyle(type: .unactive)
            }
            self.delegate?.didEndEnterPhone(phone: data)
        }
    }

    private func setSendCodeButtonView() {
        contentView.addSubview(sendCodeButtonView)
        sendCodeButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        sendCodeButtonView.buttonAction = {
            self.delegate?.didPressedSendCode()
        }
    }
//
//    private func setAllreadyHaveAccountLabel() {
//        contentView.addSubview(allreadyHaveAccountLabel)
//        allreadyHaveAccountLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(sendCodeButtonView.snp.bottom).offset(20)
//            make.centerX.equalToSuperview().offset(-20)
//            make.bottom.equalToSuperview().offset(-44)
//        }
//        allreadyHaveAccountLabel.font = UIFont.Basic.latoNormal(size: 16)
//        allreadyHaveAccountLabel.textColor = .white
//        allreadyHaveAccountLabel.text = CommonString.allreadyHaveAccount
//    }
//    
//    private func setEnterButton() {
//        contentView.addSubview(enterButton)
//        enterButton.snp.makeConstraints { (make) in
//            make.centerY.equalTo(allreadyHaveAccountLabel.snp.centerY)
//            make.left.equalTo(allreadyHaveAccountLabel.snp.right).offset(8)
//        }
//        enterButton.titleLabel?.font = UIFont.Basic.latoNormal(size: 16)
//        enterButton.setTitleColor(UIColor.Main.lightViolet, for: .normal)
//        enterButton.setTitle(CommonString.enter, for: .normal)
//        enterButton.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
//    }
}




