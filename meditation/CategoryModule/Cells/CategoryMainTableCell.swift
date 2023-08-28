//
//  CategoryMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.01.2022.
//

import UIKit
import AVKit

protocol CategoryMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
    func didPressedHeartButton()
}

class CategoryMainTableCell: UITableViewCell {
    
    let videoView = VideoPlayerView()
    
    let backButton = SquareRoundButtonView(type: .backArrow)
    let heartButton = SquareRoundButtonView(type: .heart)
    let titleLabel = UILabel()
    let progressBackView = UIView()
    let progressView = UIProgressView(progressViewStyle: .bar)
        
    weak var delegate: CategoryMainTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        
        setPlayerView()
        setBackButton()
//        setHeartButton()
        setTitleLabel()
        setProgressBackView()
        setProgressView()
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
    
    func setData(stringURL: String, title: String) {
        titleLabel.text = title
        guard let url = URL(string: stringURL) else { return }
        videoView.didLoadVideo(url: url)
    }
    
    func setProgress(progress: Float) {
        progressView.setProgress(progress, animated: false)
    }
    
    //MARK: - Private

    private func setPlayerView() {
        contentView.addSubview(videoView)
        videoView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//            make.height.equalTo(UIScreen.main.bounds.width * 0.69)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(260)
        }
        videoView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260)
    }
    
    private func setBackButton() {
        contentView.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(16)
        }
        backButton.setBackColor(color: UIColor.Main.primaryViolet.withAlphaComponent(0.2))
        backButton.buttonPressed = {
            self.delegate?.didPressedBackButton()
        }
    }
    
    private func setHeartButton() {
        contentView.addSubview(heartButton)
        heartButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-16)
        }
        heartButton.setBackColor(color: UIColor.Main.primaryViolet.withAlphaComponent(0.2))
        heartButton.buttonPressed = {
            self.delegate?.didPressedHeartButton()
        }
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(130)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Социальные проблемы"
    }
    
    
    private func setProgressBackView() {
        contentView.addSubview(progressBackView)
        progressBackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
        progressBackView.backgroundColor = UIColor.Main.borderViolet
        progressBackView.layer.cornerRadius = 6
    }
    
    private func setProgressView() {
        contentView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
//            make.top.equalTo(titleLabel.snp.bottom).offset(40)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().offset(-16)
//            make.height.equalTo(14)
            make.top.equalTo(progressBackView.snp.top).offset(1)
            make.bottom.equalTo(progressBackView.snp.bottom).offset(-2)
            make.left.equalTo(progressBackView.snp.left).offset(1)
            make.right.equalTo(progressBackView.snp.right).offset(-1)
            make.height.equalTo(14)
        }
        progressView.progressTintColor = UIColor.Main.darkViolet
        progressView.trackTintColor =  UIColor.Main.borderViolet
        progressView.setProgress(0, animated: false)
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true
    }
}

