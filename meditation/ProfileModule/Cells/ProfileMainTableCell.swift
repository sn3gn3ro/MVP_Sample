//
//  ProfileMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit
import SkeletonView

protocol ProfileMainTableCellDelegate: AnyObject {
    func favoritesPressed()
    func profileImagePressed()
    func editPressed()
}

class ProfileMainTableCell: UITableViewCell {
    
    let backImageView = UIImageView()
    let profileImageView = UIImageView()
    let profileImageButton = UIButton()
    let favoritesButton = SquareRoundButtonView(type: .headphones)
    let emailLabel = UILabel()
    let nameLabel = UILabel()
    let editButon = SquareRoundButtonView(type: .edit)
    
    weak var delegate: ProfileMainTableCellDelegate?
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        isSkeletonable = true
        
        setBackImageView()
        setProfileImageView()
        setProfileImageButton()
        setFavoritesButton()
        setEmailLabel()
        setNameLabel()
        setEditButon()
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
        backImageView.image = UIImage()
        setSkeletonableStyle()
    }
    
    func setData(backImage: UIImage, profileImage: UIImage, email: String, name: String) {
        hideSkeleton()
        backImageView.image = backImage
        profileImageView.image = profileImage
        emailLabel.text = email
        nameLabel.text = name
    }
    
    @objc func profileImageButtonAction() {
        delegate?.profileImagePressed()
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.height.equalTo(260)
        }
    }
    
    private func setProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(85)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        profileImageView.isSkeletonable = true
        profileImageView.skeletonCornerRadius = 50
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
    }
    
    private func setProfileImageButton() {
        contentView.addSubview(profileImageButton)
        profileImageButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.centerX.equalTo(profileImageView.snp.centerX)
            make.height.width.equalTo(150)
        }
        profileImageButton.addTarget(self, action: #selector(profileImageButtonAction), for: .touchUpInside)
    }
    
    private func setFavoritesButton() {
        contentView.addSubview(favoritesButton)
        favoritesButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-17)
            make.height.width.equalTo(40)
        }
        favoritesButton.setBackColor(color: UIColor.Main.primaryViolet.withAlphaComponent(0.2))
        favoritesButton.buttonPressed = {
            self.delegate?.favoritesPressed()
        }
        favoritesButton.isSkeletonable = true
        favoritesButton.skeletonCornerRadius = 12
    }
    
    private func setEmailLabel() {
        contentView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backImageView.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(22)
        }
        emailLabel.textAlignment = .left
        emailLabel.font = UIFont.Basic.latoNormal(size: 16)
        emailLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        emailLabel.isSkeletonable = true
        emailLabel.linesCornerRadius = 4
        emailLabel.skeletonTextLineHeight = SkeletonTextLineHeight.relativeToFont
        emailLabel.lastLineFillPercent = 20
    }
    
    private func setNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(43)
        }
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.Basic.latoBold(size: 38)
        nameLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        nameLabel.isSkeletonable = true
        nameLabel.linesCornerRadius = 4
        nameLabel.skeletonTextLineHeight = SkeletonTextLineHeight.relativeToFont
    }
    
    private func setEditButon() {
        contentView.addSubview(editButon)
        editButon.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(48)
            make.bottom.equalToSuperview().offset(-20)
        }
        editButon.setBackColor(color: UIColor.white.withAlphaComponent(0.3))
        editButon.buttonPressed = {
            self.delegate?.editPressed()
        }
        editButon.isSkeletonable = true
        editButon.skeletonCornerRadius = 12
    }
    
}
