//
//  MainPodcastTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 19.01.2022.
//

import UIKit
import SkeletonView

class MainPodcastTableCell: UITableViewCell {
    
//    let backImageView = UIImageView()
    let videoView = VideoPlayerView()
    let blackerView = UIView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        isSkeletonable = true
        
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
    
    func setSkeleton() {
        titleLabel.text = ""
        subTitleLabel.text = ""
        blackerView.isHidden = true
        setSkeletonableStyle()
    }
    
    func setData(videoUrl: String, bufferedLink: URL?, title: String, subTitle: String) {
        hideSkeleton()
        titleLabel.text = title
        subTitleLabel.text = subTitle
        blackerView.isHidden = false
        if let bufferedLink = bufferedLink {
            videoView.didLoadVideo(url: bufferedLink)
        }
       
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(videoView)
        videoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(184)
        }
        videoView.clipsToBounds = true
        videoView.layer.cornerRadius = 17
        videoView.isSkeletonable = true
        videoView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - (16*2), height: 184)
    }
    
    private func setBlackerView() {
        contentView.addSubview(blackerView)
        blackerView.snp.makeConstraints { (make) in
            make.edges.equalTo(videoView)
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

