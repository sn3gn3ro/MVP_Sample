//
//  ElementInCategoryCollectionCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.01.2022.
//

import UIKit

class ElementInCategoryCollectionCell: UICollectionViewCell {
    
    let videoView = VideoPlayerView()
    var blurEffectView =  UIVisualEffectView()
    let lessonNameLabel = UILabel()
    let statusImageView  = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackImageView()
        setBlurEffectView()
        setLessonNameLabel()
        setStatusImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Actions
    
    func setData(videoUrl: String, bufferedLink: URL?, lessonName: String, isLissend: Bool) {
        lessonNameLabel.text = lessonName
        statusImageView.image = isLissend ? UIImage(named: "checkPurple") :  UIImage(named: "playPurple")
        if let bufferedLink = bufferedLink {
            videoView.layoutIfNeeded()
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
//            make.height.equalTo(146)
            make.bottom.equalToSuperview()
        }
        videoView.clipsToBounds = true
        videoView.layer.cornerRadius = 16
        videoView.contentMode = .scaleAspectFill
    }
    
    private func setBlurEffectView() {
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style:.systemThinMaterialDark))
        contentView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
        blurEffectView.alpha = 0.4
    }
    
    private func setLessonNameLabel() {
        contentView.addSubview(lessonNameLabel)
        lessonNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(videoView.snp.bottom).offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
//            make.height.equalTo(16)
        }
        lessonNameLabel.textAlignment = .left
        lessonNameLabel.font = UIFont.Basic.latoNormal(size: 14)
        lessonNameLabel.textColor = UIColor.white
        lessonNameLabel.numberOfLines = 0
    }
    
    private func setStatusImageView() {
        contentView.addSubview(statusImageView)
        statusImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(24)
        }
       
    }
    
}




