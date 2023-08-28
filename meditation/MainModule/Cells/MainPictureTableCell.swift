//
//  MainPictureTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import UIKit

class MainPictureTableCell: UITableViewCell {
    
//    let backImageView = UIImageView()
    let videoView = VideoPlayerView()
    
//    weak var delegate: MainPictureTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        setBackImageView()
     
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
    
    func setData(videoUrl: String, bufferedLink: URL?) {
        if let bufferedLink = bufferedLink {
            videoView.didLoadVideo(url: bufferedLink)
        }
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(videoView)
        videoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(260)
        }
    }
}
