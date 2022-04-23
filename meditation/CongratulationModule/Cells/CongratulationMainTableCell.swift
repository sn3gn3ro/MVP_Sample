//
//  CongratulationMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 28.01.2022.
//

import UIKit

class CongratulationMainTableCell: UITableViewCell {
    
    let backImageView = UIImageView()
    let titleLabel = UILabel()
    let congratulationLabel = UILabel()
    let shareButton = SquareRoundButtonView(type: .share)
    let readyForNewChallengeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setBackImageView()
        setTitleLabel()
        setCongratulationLabel()
        setShareButton()
        setReadyForNewChallengeLabel()
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
    
    func setImage(image: UIImage) {
        backImageView.image = image
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(250)
        }
        backImageView.image = UIImage(named: "congratulationTop")
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backImageView.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(22)
        }
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 16)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        titleLabel.text = CommonString.allLessonComplete
    }
    
    private func setCongratulationLabel() {
        contentView.addSubview(congratulationLabel)
        congratulationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-70)
//            make.bottom.equalToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(43)
        }
        congratulationLabel.numberOfLines = 0
        congratulationLabel.textAlignment = .left
        congratulationLabel.font = UIFont.Basic.latoBold(size: 38)
        congratulationLabel.textColor = UIColor.white
        congratulationLabel.text = CommonString.congraulation
    }
    
    private func setShareButton() {
        contentView.addSubview(shareButton)
        shareButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(congratulationLabel.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(48)
        }
        shareButton.setBackColor(color: UIColor.white.withAlphaComponent(0.3))
        shareButton.buttonPressed = {
            
        }
    }
    
    private func setReadyForNewChallengeLabel() {
        contentView.addSubview(readyForNewChallengeLabel)
        readyForNewChallengeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(congratulationLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        readyForNewChallengeLabel.numberOfLines = 0
        readyForNewChallengeLabel.textAlignment = .left
        readyForNewChallengeLabel.font = UIFont.Basic.latoNormal(size: 18)
        readyForNewChallengeLabel.textColor = UIColor.Main.textGray
        readyForNewChallengeLabel.text = CommonString.readyForNewChallenge
    }
}

