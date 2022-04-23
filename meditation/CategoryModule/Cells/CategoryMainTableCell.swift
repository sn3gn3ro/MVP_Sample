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
    
    let videoLayer = UIView()
    var videoPath = Bundle.main.path(forResource: "ivening_1", ofType: "mp4")
    var player = AVPlayer()
    
    let backButton = SquareRoundButtonView(type: .backArrow)
    let heartButton = SquareRoundButtonView(type: .heart)
    let titleLabel = UILabel()
    let progressView = UIProgressView(progressViewStyle: .bar)
    
    weak var delegate: CategoryMainTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        
        setPlayerView()
        setBackButton()
        setHeartButton()
        setTitleLabel()
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
    
    func setImage(videoPath: String, title: String) {
        self.videoPath = videoPath
        titleLabel.text = title
    }
    
    //MARK: - Private
    
    private func setPlayerView() {
        contentView.addSubview(videoLayer)
        videoLayer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.69)
        }
    
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: self.player.currentItem)
        
        guard let videoPath = videoPath else { return }
        player = AVPlayer(url: URL(fileURLWithPath: videoPath))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.69)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.contentsGravity = .resizeAspectFill
        self.videoLayer.layer.addSublayer(playerLayer)
        
        player.play()
    }
    
    @objc func playerItemDidReachEnd() {
        self.player.seek(to: CMTime.zero)
       self.player.play()
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
    
    private func setProgressView() {
        contentView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }
        progressView.progressTintColor = UIColor.Main.darkViolet
        progressView.trackTintColor =  UIColor.Main.borderViolet
        progressView.setProgress(Float(1) / Float(2), animated: false)
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true
    }
}

