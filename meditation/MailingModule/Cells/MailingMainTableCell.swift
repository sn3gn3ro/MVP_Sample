//
//  MailingMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit

protocol MailingMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
    func didPressedFurtherButton()
    func didEndEnterEmil(email: String)
}

class MailingMainTableCell: UITableViewCell {
    
    let starsBackImageView = UIImageView()
    let meditationLogoImageView = UIImageView()
    let backArrowImageView = UIImageView()
    let backArrowButton = UIButton()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let emailView = DataEnterView(type: .email)
    let furtherButtonView = SimpleTextButtonView(type: .normal, text: CommonString.further)

  
    weak var delegate: MailingMainTableCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setStarsBackImageView()
        setMeditationLogoImageView()
        setBackArrowImageView()
        setBackArrowButton()
        setTitleLabel()
        setSubtitleLabel()
        setEmailView()
        setFurtherButtonView()
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
    
    func setData(email: String?) {
        emailView.setData(text: email)
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
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meditationLogoImageView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(38)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.text = CommonString.firstMainStep
    }
    
    private func setSubtitleLabel() {
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        subtitleLabel.textAlignment = .left
        subtitleLabel.font = UIFont.Basic.latoNormal(size: 16)
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = CommonString.firstMainStepSubtitle
    }
    
    private func setEmailView() {
        contentView.addSubview(emailView)
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        emailView.dataEndEditing = { data in
            if self.emailView.isDataValidate {
                self.furtherButtonView.setStyle(type: .normal)
            } else {
                self.furtherButtonView.setStyle(type: .unactive)
            }
            self.delegate?.didEndEnterEmil(email: data)
        }
    }

    private func setFurtherButtonView() {
        contentView.addSubview(furtherButtonView)
        furtherButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        furtherButtonView.buttonAction = {
            self.delegate?.didPressedFurtherButton()
        }
    }

}






