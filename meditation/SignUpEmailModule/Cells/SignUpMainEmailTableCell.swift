//
//  SignUpMainEmailTableCell.swift.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.12.2021.
//

import UIKit

protocol SignUpMainEmailTableCellDelegate: AnyObject {
    func didPressedBackButton()
    func didPressedCreateAccount()
    func didPressedEnter()
    
    func didEnterName(name: String)
    func didEnterEmail(email: String)
    func didEnterPassword(password: String)
    func didEnterComfirmPassword(password: String)
}

class SignUpMainEmailTableCell: UITableViewCell {
    
    let starsBackImageView = UIImageView()
    let meditationLogoImageView = UIImageView()
    let backArrowImageView = UIImageView()
    let backArrowButton = UIButton()
    let nameView = DataEnterView(type: .name)
    let emailView = DataEnterView(type: .email)
    let passwordView = DataEnterView(type: .password)
    let passwordComfirmView = DataEnterView(type: .password)
    let createAccountView = SimpleTextButtonView(type: .unactive, text: CommonString.createAccount)
    let allreadyHaveAccountLabel = UILabel()
    let enterButton = UIButton()
  
    weak var delegate: SignUpMainEmailTableCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setStarsBackImageView()
        setMeditationLogoImageView()
        setBackArrowImageView()
        setBackArrowButton()
        setNameView()
        setEmailView()
        setPasswordView()
        setPasswordComfirmView()
        setСreateAccountView()
        setAllreadyHaveAccountLabel()
        setEnterButton()
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
        delegate?.didPressedEnter()
    }
    
    func setData(email: String?, password: String?) {
        emailView.setData(text: email)
        passwordView.setData(text: password)
    }
    
    func setCreateAccountActive() {
        createAccountView.setStyle(type: .normal)
    }
    
    func setCreateAccountUnactive() {
        createAccountView.setStyle(type: .unactive)
    }
    
    //MARK: - Private
    
    private func testPasswordIdentical() {
        if !(passwordComfirmView.getText()?.isEmpty ?? true) {
            if passwordView.getText() == passwordComfirmView.getText() {
                passwordComfirmView.setSuccessState()
                passwordView.setSuccessState()
                delegate?.didEnterPassword(password: passwordView.getText() ?? "")
            } else {
                passwordComfirmView.setErrorState(errorText: CommonString.passwordsAreDifferent)
                passwordView.setErrorState(errorText: CommonString.passwordsAreDifferent)
            }
        }
    }
    
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
    
    private func setNameView() {
        contentView.addSubview(nameView)
        nameView.snp.makeConstraints { (make) in
            make.top.equalTo(meditationLogoImageView.snp.bottom).offset(57)
            make.centerX.equalToSuperview()
        }
        nameView.dataEndEditing = { data in
            self.delegate?.didEnterName(name: data)
        }
    }
    
    private func setEmailView() {
        contentView.addSubview(emailView)
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(nameView.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        }
        
        emailView.dataEndEditing = { data in
            self.delegate?.didEnterEmail(email: data)
        }
    }
    
    private func setPasswordView() {
        contentView.addSubview(passwordView)
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        }
        
        passwordView.dataEndEditing = { [weak self] data in
            guard let `self` = self else { return }
            self.testPasswordIdentical()
        }
        
        passwordView.dataBeginEditing = { [weak self] data in
            guard let `self` = self else { return }
            self.passwordView.setInitialState()
            self.passwordComfirmView.setInitialState()
        }
    }
    
    private func setPasswordComfirmView() {
        contentView.addSubview(passwordComfirmView)
        passwordComfirmView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        }
        
        passwordComfirmView.dataEndEditing = { [weak self] data in
            guard let `self` = self else { return }
            self.testPasswordIdentical()
        }
        
        passwordComfirmView.dataBeginEditing = { [weak self] data in
            guard let `self` = self else { return }
            self.passwordView.setInitialState()
            self.passwordComfirmView.setInitialState()
        }
    }
    
    private func setСreateAccountView() {
        contentView.addSubview(createAccountView)
        createAccountView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordComfirmView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        createAccountView.buttonAction = {
            self.delegate?.didPressedCreateAccount()
        }
    }

    private func setAllreadyHaveAccountLabel() {
        contentView.addSubview(allreadyHaveAccountLabel)
        allreadyHaveAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountView.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-44)
        }
        allreadyHaveAccountLabel.font = UIFont.Basic.latoNormal(size: 16)
        allreadyHaveAccountLabel.textColor = .white
        allreadyHaveAccountLabel.text = CommonString.allreadyHaveAccount
    }
    
    private func setEnterButton() {
        contentView.addSubview(enterButton)
        enterButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(allreadyHaveAccountLabel.snp.centerY)
            make.left.equalTo(allreadyHaveAccountLabel.snp.right).offset(8)
        }
        enterButton.titleLabel?.font = UIFont.Basic.latoNormal(size: 16)
        enterButton.setTitleColor(UIColor.Main.lightViolet, for: .normal)
        enterButton.setTitle(CommonString.enter, for: .normal)
        enterButton.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
    }
}


