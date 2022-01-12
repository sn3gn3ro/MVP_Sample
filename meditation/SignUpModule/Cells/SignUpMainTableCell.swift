//
//  SignUpMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit

protocol SignUpMainTableCellDelegate: AnyObject {
    func didPressedGoogle()
    func didPressedApple()
    func didPressedPhone()
    func didPressedCreateAccount()
    func didPressedEnter()
    
    func didEnterEmail(email: String)
    func didEnterPassword(password: String)
}

class SignUpMainTableCell: UITableViewCell {
    
    let starsBackImageView = UIImageView()
    let meditationLogoImageView = UIImageView()
    let subtitleLabel = UILabel()
    let emailView = DataEnterView(type: .email)
    let passwordView = DataEnterView(type: .password)
    let errorLabel = UILabel()
    let createAccountView = SimpleTextButtonView(type: .normal, text: CommonString.createAccount)
    let privatePolicyTextView = UITextView()
    let orLabel = UILabel()
    let leftLineView = UIView()
    let rightLineView = UIView()
    let appleRegistrationView = RegistrationButtonView(type: .apple)
    let googleRegistrationView = RegistrationButtonView(type: .google)
    let phoneRegistrationView = RegistrationButtonView(type: .phone)
    let allreadyHaveAccountLabel = UILabel()
    let enterButton = UIButton()
    
    var linkAction:(()->())?
  
    weak var delegate: SignUpMainTableCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setStarsBackImageView()
        setMeditationLogoImageView()
        setSubtitleLabel()
        setEmailView()
        setPasswordView()
        setErrorLabel()
        setСreateAccountView()
        setPrivatePolicyTextView()
        setOrLabel()
        setLeftLineView()
        setRightLineView()
        setAppleRegistrationView()
        setGoogleRegistrationView()
        setPhoneRegistrationView()
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
    
    @objc private func enterButtonAction() {
        delegate?.didPressedEnter()
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
            make.top.equalToSuperview().offset(114)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(223)
        }
        meditationLogoImageView.image = UIImage(named: "meditationLogo")
    }
    
    private func setSubtitleLabel() {
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meditationLogoImageView.snp.bottom)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
        }
        subtitleLabel.font = UIFont.Basic.latoHairline(size: 18)
        subtitleLabel.textColor = .white
        subtitleLabel.text = CommonString.lifeInHormony
    }
    
    private func setEmailView() {
        contentView.addSubview(emailView)
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
        emailView.dataEndEditing = { data in
            self.delegate?.didEnterEmail(email: data)
        }
        
        emailView.dataBeginEditing = { data in
            self.emailView.setInitialState()
            self.passwordView.setInitialState()
            self.errorLabel.isHidden = true
        }
    }
    
    private func setPasswordView() {
        contentView.addSubview(passwordView)
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(-4)
            make.centerX.equalToSuperview()
        }
        
        passwordView.dataEndEditing = { data in
            self.delegate?.didEnterPassword(password: data)
        }
        
        passwordView.dataBeginEditing = { data in
            self.emailView.setInitialState()
            self.passwordView.setInitialState()
            self.errorLabel.isHidden = true
        }
    }
    
    private func setErrorLabel() {
        contentView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(-16)
            make.height.equalTo(16)
            make.centerX.equalToSuperview()
        }
        errorLabel.font = UIFont.Basic.latoNormal(size: 12)
        errorLabel.textColor = UIColor.Main.errorRed
        errorLabel.text = CommonString.wrongEmailOrPassword
        errorLabel.isHidden = true
    }
    
    private func setСreateAccountView() {
        contentView.addSubview(createAccountView)
        createAccountView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        createAccountView.buttonAction = {
            if self.emailView.isDataValidate{
                self.delegate?.didPressedCreateAccount()
            } else {
                self.emailView.setErrorState(errorText: "")
                self.passwordView.setErrorState(errorText: "")
                self.errorLabel.isHidden = false
            }
        }
    }
    
    private func setPrivatePolicyTextView() {
        contentView.addSubview(privatePolicyTextView)
        privatePolicyTextView.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountView.snp.bottom).offset(12)//(24)
            make.centerX.equalToSuperview()
        }

        let attributedString = NSMutableAttributedString(string: CommonString.privacyPoliticsFirstHalf + CommonString.privacyPoliticsSecontHalf)
        let textBeforeRules = CommonString.privacyPoliticsFirstHalf
        let rules = CommonString.privacyPoliticsSecontHalf
        let rulesUrl = URL(fileURLWithPath: "object")
       
        attributedString.addAttribute(.link, value: rulesUrl, range:  NSMakeRange(textBeforeRules.count, rules.count))
        privatePolicyTextView.delegate = self
        privatePolicyTextView.attributedText = attributedString
        privatePolicyTextView.font = UIFont.Basic.latoNormal(size: 12)
        privatePolicyTextView.isScrollEnabled = false
        privatePolicyTextView.textColor = .white
        privatePolicyTextView.backgroundColor = .clear
        privatePolicyTextView.textAlignment = .center
        privatePolicyTextView.isUserInteractionEnabled = true
        privatePolicyTextView.isEditable = false
        privatePolicyTextView.linkTextAttributes = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    
    private func setOrLabel() {
        contentView.addSubview(orLabel)
        orLabel.snp.makeConstraints { (make) in
            make.top.equalTo(privatePolicyTextView.snp.bottom).offset(42)//(54)
            make.centerX.equalToSuperview()
        }
        orLabel.font = UIFont.Basic.latoHairline(size: 12)
        orLabel.textColor = UIColor.Main.lightGray
        orLabel.text = CommonString.or
    }
    
    private func setLeftLineView() {
        contentView.addSubview(leftLineView)
        leftLineView.snp.makeConstraints { (make) in
            make.centerY.equalTo(orLabel.snp.centerY)
            make.right.equalTo(orLabel.snp.left).offset(-16)
            make.height.equalTo(1)
            make.width.equalTo(70)
        }
        leftLineView.backgroundColor = .white
    }
    
    private func setRightLineView() {
        contentView.addSubview(rightLineView)
        rightLineView.snp.makeConstraints { (make) in
            make.centerY.equalTo(orLabel.snp.centerY)
            make.left.equalTo(orLabel.snp.right).offset(16)
            make.height.equalTo(1)
            make.width.equalTo(70)
        }
        rightLineView.backgroundColor = .white
    }
    
    private func setAppleRegistrationView() {
        contentView.addSubview(appleRegistrationView)
        appleRegistrationView.snp.makeConstraints { (make) in
            make.top.equalTo(orLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        appleRegistrationView.buttonAction = {
            self.delegate?.didPressedApple()
        }
    }
    
    private func setGoogleRegistrationView() {
        contentView.addSubview(googleRegistrationView)
        googleRegistrationView.snp.makeConstraints { (make) in
            make.centerY.equalTo(appleRegistrationView.snp.centerY)
            make.right.equalTo(appleRegistrationView.snp.left).offset(-24)
        }
        googleRegistrationView.buttonAction = {
            self.delegate?.didPressedGoogle()
        }
    }
    
    private func setPhoneRegistrationView() {
        contentView.addSubview(phoneRegistrationView)
        phoneRegistrationView.snp.makeConstraints { (make) in
            make.centerY.equalTo(appleRegistrationView.snp.centerY)
            make.left.equalTo(appleRegistrationView.snp.right).offset(24)
        }
        phoneRegistrationView.buttonAction = {
            self.delegate?.didPressedPhone()
        }
    }
    
    private func setAllreadyHaveAccountLabel() {
        contentView.addSubview(allreadyHaveAccountLabel)
        allreadyHaveAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(googleRegistrationView.snp.bottom).offset(66)
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

extension SignUpMainTableCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            switch URL.lastPathComponent {
            case "user":    print("user action")
            case "object": linkAction?()
            default: break
            }
            return true
        }
}
