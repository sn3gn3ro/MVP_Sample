//
//  RestoreEmailPasswordMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import UIKit

protocol RestoreEmailPasswordMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
    func didPressedRestorePassword()
    func didEndEnterEmil(email: String)
}

class RestoreEmailPasswordMainTableCell: UITableViewCell {
    
    let starsBackImageView = UIImageView()
    let meditationLogoImageView = UIImageView()
    let backArrowImageView = UIImageView()
    let backArrowButton = UIButton()
    let emailView = DataEnterView(type: .email)
    let restorePasswordButtonView = SimpleTextButtonView(type: .unactive, text: CommonString.restorePassword)

  
    weak var delegate: RestoreEmailPasswordMainTableCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setStarsBackImageView()
        setMeditationLogoImageView()
        setBackArrowImageView()
        setBackArrowButton()
        setEmailView()
        setRestorePasswordButtonView()
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
        
        emailView.dataEndEditing = { data in
            if self.emailView.isDataValidate {
                self.restorePasswordButtonView.setStyle(type: .normal)
            } else {
                self.restorePasswordButtonView.setStyle(type: .unactive)
            }
            self.delegate?.didEndEnterEmil(email: data)
        }
    }

    private func setRestorePasswordButtonView() {
        contentView.addSubview(restorePasswordButtonView)
        restorePasswordButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        restorePasswordButtonView.buttonAction = {
            self.delegate?.didPressedRestorePassword()
        }
    }

}





