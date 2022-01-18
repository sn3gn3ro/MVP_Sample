//
//  MainPodcastsHeaderTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 19.01.2022.
//

import UIKit

protocol MainPodcastsHeaderTableCellDelegate: AnyObject {
    func moreButtonPressed()
}

class MainPodcastsHeaderTableCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let moreLabel = UILabel()
    let moreButton = UIButton()
    
    weak var delegate: MainPodcastsHeaderTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
    
        setTitleLabel()
        setMoreLabel()
        setMoreButton()
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

    @objc func moreButtonAction() {
        delegate?.moreButtonPressed()
    }
    
    //MARK: - Private
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(22)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 18)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        titleLabel.text = CommonString.podcastTheme
    }
    
    private func setMoreLabel() {
        contentView.addSubview(moreLabel)
        moreLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(22)
        }
        moreLabel.textAlignment = .right
        moreLabel.font = UIFont.Basic.latoNormal(size: 14)
        moreLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        moreLabel.text = CommonString.more
    }
    
    private func setMoreButton() {
        contentView.addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(moreLabel.snp.width)
            make.left.equalTo(moreLabel.snp.left)
            make.right.equalTo(moreLabel.snp.right)
        }
        moreButton.addTarget(self, action: #selector(moreButtonAction), for: .touchUpInside)
    }
}
