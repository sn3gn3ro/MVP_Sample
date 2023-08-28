//
//  LogInEmailMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import UIKit

protocol LogInEmailMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
    func didPressedRestore()
    func didPressedEnter()
    
    func didEnterEmail(email: String)
    func didEnterPassword(password: String)
}

class LogInEmailMainTableCell: UITableViewCell {
    
    let starsBackImageView = UIImageView()
    let meditationLogoImageView = UIImageView()
    let backArrowImageView = UIImageView()
    let backArrowButton = UIButton()
    let emailView = DataEnterView(type: .email)
    let passwordView = DataEnterView(type: .password)
    let enterButtonView = SimpleTextButtonView(type: .unactive, text: CommonString.enter)
    let forgotPasswordLabel = UILabel()
    let restoreButton = UIButton()
  
    weak var delegate: LogInEmailMainTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setStarsBackImageView()
        setMeditationLogoImageView()
        setBackArrowImageView()
        setBackArrowButton()
        setEmailView()
        setPasswordView()
        setForgotPasswordLabel()
        setRestoreButton()
        setEnterButtonView()
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
    
    @objc private func restoreButtonAction() {
        delegate?.didPressedRestore()
    }
    
    func setData(email: String, password: String) {
        emailView.setData(text: email)
        passwordView.setData(text: password)
    }
    
    func setCreateAccountActive() {
        enterButtonView.setStyle(type: .normal)
    }
    
    func setCreateAccountUnactive() {
        enterButtonView.setStyle(type: .unactive)
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
    
    private func setEmailView() {
        contentView.addSubview(emailView)
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(meditationLogoImageView.snp.bottom).offset(57)
            make.centerX.equalToSuperview()
        }
        
        emailView.dataEndEditing = { [weak self] data in
            self?.delegate?.didEnterEmail(email: data)
        }
    }
    
    private func setPasswordView() {
        contentView.addSubview(passwordView)
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        }
        
        passwordView.dataEndEditing = { [weak self] data in
            self?.delegate?.didEnterPassword(password: data)
        }
    }
    
    private func setForgotPasswordLabel() {
        contentView.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(28)
            make.height.equalTo(22)
            make.right.equalTo(snp.centerX)
        }
        forgotPasswordLabel.font = UIFont.Basic.latoNormal(size: 16)
        forgotPasswordLabel.textColor = .white
        forgotPasswordLabel.text = CommonString.forgotPassword
    }
    
    private func setRestoreButton() {
        contentView.addSubview(restoreButton)
        restoreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(forgotPasswordLabel.snp.centerY)
            make.left.equalTo(forgotPasswordLabel.snp.right).offset(8)
        }
        restoreButton.titleLabel?.font = UIFont.Basic.latoNormal(size: 16)
        restoreButton.setTitleColor(UIColor.Main.lightViolet, for: .normal)
        restoreButton.setTitle(CommonString.restore, for: .normal)
        restoreButton.addTarget(self, action: #selector(restoreButtonAction), for: .touchUpInside)
    }
    
    private func setEnterButtonView() {
        contentView.addSubview(enterButtonView)
        enterButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
        }
        
        enterButtonView.buttonAction = { [weak self] in
            self?.delegate?.didPressedEnter()
        }
    }

   
}



