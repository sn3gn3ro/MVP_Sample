//
//  MainPodcastTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 19.01.2022.
//

import UIKit

class MainPodcastTableCell: UITableViewCell {
    
    let backImageView = UIImageView()
    let blackerView = UIView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
//    weak var delegate: MainPlayedTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        
        setBackImageView()
        setBlackerView()
        setTitleLabel()
        setSubTitleLabel()
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
    
    func setData(backImage: UIImage, title: String, subTitle: String) {
        backImageView.image = backImage
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(184)
        }
        backImageView.clipsToBounds = true
        backImageView.layer.cornerRadius = 17
    }
    
    private func setBlackerView() {
        contentView.addSubview(blackerView)
        blackerView.snp.makeConstraints { (make) in
            make.edges.equalTo(backImageView)
        }
        blackerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        blackerView.clipsToBounds = true
        blackerView.layer.cornerRadius = 17
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(108)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(24)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoBold(size: 26)
        titleLabel.textColor = UIColor.white
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
        subTitleLabel.textColor = UIColor.Main.textGray
    }
}

