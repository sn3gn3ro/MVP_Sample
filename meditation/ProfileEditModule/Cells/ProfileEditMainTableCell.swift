//
//  ProfileEditMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit

protocol ProfileEditMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
    func didEnterName(name: String)
    func didEnterEmail(email: String)
    func didEnterPhone(phone: String)
    func didPressedSaveChanges()
    func didPressedDeleteAccount()
}

class ProfileEditMainTableCell: UITableViewCell {
    
    let backButtonView = SquareRoundButtonView(type: .backArrow)
    let titleLabel = UILabel()
    let nameView = DataEnterView(type: .name)
    let emailView = DataEnterView(type: .email)
    let phoneView = DataEnterView(type: .phone)
    let saveChangesButton = SimpleTextButtonView(type: .normal, text: CommonString.saveChanges)
    let deleteAccountButtonView = TextImageButtonView(type: .bordered, text: CommonString.deleteAccount, icon: UIImage(named: "trashBin") ?? UIImage())
    
    weak var delegate: ProfileEditMainTableCellDelegate?
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setИackButtonView()
        setTitleLabel()
        setNameView()
        setEmailView()
        setPhoneView()
        setSaveChangesButton()
        setDeleteAccountButtonView()
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
    
    func setData(name: String,email: String, phone: String) {
        nameView.setData(text: name)
        emailView.setData(text: email)
        phoneView.setData(text: phone)
    }
    
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
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.text = CommonString.editData
    }
    
    private func setNameView() {
        contentView.addSubview(nameView)
        nameView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        nameView.dataEndEditing = { data in
            self.delegate?.didEnterName(name: data)
        }
        
        nameView.dataBeginEditing = { data in
            self.nameView.setInitialState()
        }
    }
    
    private func setEmailView() {
        contentView.addSubview(emailView)
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(nameView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        emailView.dataEndEditing = { data in
            self.delegate?.didEnterEmail(email: data)
        }
        
        emailView.dataBeginEditing = { data in
            self.emailView.setInitialState()
        }
    }
    
    private func setPhoneView() {
        contentView.addSubview(phoneView)
        phoneView.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        phoneView.dataEndEditing = { data in
            self.delegate?.didEnterPhone(phone: data)
        }
        
        phoneView.dataBeginEditing = { data in
            self.phoneView.setInitialState()
        }
    }
    
    private func setSaveChangesButton() {
        contentView.addSubview(saveChangesButton)
        saveChangesButton.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp.bottom).offset(2)
        }
        
        saveChangesButton.buttonAction = {
            self.delegate?.didPressedSaveChanges()
        }
    }
    
    private func setDeleteAccountButtonView() {
        contentView.addSubview(deleteAccountButtonView)
        deleteAccountButtonView.snp.makeConstraints { (make) in
//            make.top.equalTo(saveChangesButton.snp.bottom).offset(248)
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height - 100)
            make.bottom.equalToSuperview()
        }
        
        deleteAccountButtonView.buttonAction = {
            self.delegate?.didPressedDeleteAccount()
        }
    }
    
    
}

