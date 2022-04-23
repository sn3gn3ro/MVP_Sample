//
//  FavoriteTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import UIKit

protocol FavoriteTableCellDelegate: AnyObject {
    func playButtonPressed()
}

class FavoriteTableCell: UITableViewCell {
    
    let backImageView = UIImageView()
    let blackerView = UIView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let dotView = UIView()
    let timeLabel = UILabel()
    let playButtonImageView = UIImageView()
    let playButton = UIButton()
    
    weak var delegate: FavoriteTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
//        contentView.layer.cornerRadius = 14
        
        setBackImageView()
        setBlackerView()
        setTitleLabel()
        setSubTitleLabel()
        setDotView()
        setTimeLabel()
        setPlayButtonImageView()
        setPlayButton()
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
    
    func setData(backImage: UIImage, title: String, subTitle: String, time: String) {
        backImageView.image = backImage
        titleLabel.text = title
        subTitleLabel.text = subTitle
        timeLabel.text = time
    }
    
    @objc func playButtonPressed() {
        delegate?.playButtonPressed()
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(88)
        }
        backImageView.clipsToBounds = true
        backImageView.layer.cornerRadius = 14
    }
    
    private func setBlackerView() {
        contentView.addSubview(blackerView)
        blackerView.snp.makeConstraints { (make) in
            make.edges.equalTo(backImageView)
        }
        blackerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        blackerView.clipsToBounds = true
        blackerView.layer.cornerRadius = 14
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(19)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(24)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoBold(size: 18)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
    }
    
    private func setSubTitleLabel() {
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(32)
            make.height.equalTo(19)
        }
        subTitleLabel.numberOfLines = 1
        subTitleLabel.textAlignment = .left
        subTitleLabel.font = UIFont.Basic.latoNormal(size: 14)
        subTitleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
    }
    
    private func setDotView() {
        contentView.addSubview(dotView)
        dotView.snp.makeConstraints { (make) in
            make.centerY.equalTo(subTitleLabel.snp.centerY)
            make.left.equalTo(subTitleLabel.snp.right).offset(8)
            make.height.width.equalTo(6)
        }
        dotView.layer.cornerRadius = 3
        dotView.backgroundColor = .white
    }
    
    private func setTimeLabel() {
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dotView.snp.centerY)
            make.left.equalTo(dotView.snp.right).offset(8)
//            make.right.greaterThanOrEqualToSuperview().offset(-60)
            make.height.equalTo(19)
        }
        timeLabel.numberOfLines = 1
        timeLabel.textAlignment = .left
        timeLabel.font = UIFont.Basic.latoNormal(size: 14)
        timeLabel.textColor = UIColor.Main.textGray
    }
    
    private func setPlayButtonImageView() {
        contentView.addSubview(playButtonImageView)
        playButtonImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-32)
            make.height.width.equalTo(30)
        }
        playButtonImageView.image = UIImage(named: "play")
    }
    
    private func setPlayButton() {
        contentView.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.center.equalTo(playButtonImageView.snp.center)
            make.height.width.equalTo(60)
        }
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
    }
    
}



