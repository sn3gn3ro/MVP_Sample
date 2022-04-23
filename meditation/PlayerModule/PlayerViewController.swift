//
//  PlayerViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.01.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let backImageView = UIImageView()
    let backButton = SquareRoundButtonView(type: .backArrow)
    let heartButton = SquareRoundButtonView(type: .heart)
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    let playPausePlayerButtonImageView = UIImageView()
    let backPlayerButtonImageView = UIImageView()
    let forwardPlayerButtonImageView = UIImageView()
    
    
    let playPausePlayerButton = UIButton()
    let backPlayerButton = UIButton()
    let forwardPlayerButton = UIButton()
    
    
    let playerTrackView = PlayerTrackView()
    
    var presenter: PlayerPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackImageView()
        setBackButton()
        setHeartButton()
        
        setPlayerTrackView()
        
        setPlayPausePlayerButtonImageView()
        setBackPlayerButtonImageView()
        setForwardPlayerButtonImageView()
        
        setPlayPausePlayerButton()
        setBackPlayerButton()
        setForwardPlayerButton()
        
        setSubtitleLabel()
        setTitleLabel()
    }
    

    // MARK: - Private
    
    @objc func playPausePlayerButtonAction() {
        
    }
    
    @objc func playerBackButtonAction() {
       
    }
    
    @objc func forwardPlayerButtonAction() {
        
    }
    
    private func setBackImageView() {
        view.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backImageView.image = UIImage(named: "backNightTest")
        backImageView.clipsToBounds = true
        backImageView.contentMode = .scaleAspectFill
        backImageView.hero.modifiers = [.translate(y: 500), .useGlobalCoordinateSpace]
    }

    private func setBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(16)
        }
        backButton.setBackColor(color: UIColor.Main.primaryViolet.withAlphaComponent(0.2))
        backButton.buttonPressed = {
            self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setHeartButton() {
        view.addSubview(heartButton)
        heartButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-16)
        }
        heartButton.setBackColor(color: UIColor.Main.primaryViolet.withAlphaComponent(0.2))
        heartButton.buttonPressed = {
            ModuleRouter.showCongratulationModule(currentViewController: self)
        }
    }
    
    private func setPlayerTrackView() {
        view.addSubview(playerTrackView)
        playerTrackView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-60)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
    }
    
    
    private func setPlayPausePlayerButtonImageView() {
        view.addSubview(playPausePlayerButtonImageView)
        playPausePlayerButtonImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(playerTrackView.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(64)
        }
        playPausePlayerButtonImageView.image = UIImage(named: "playerPlay")
    }
    
    private func setBackPlayerButtonImageView() {
        view.addSubview(backPlayerButtonImageView)
        backPlayerButtonImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(playPausePlayerButtonImageView.snp.centerY)
            make.right.equalTo(playPausePlayerButtonImageView.snp.left).offset(-40)
            make.height.width.equalTo(24)
        }
        backPlayerButtonImageView.image = UIImage(named: "playerBackActive")
    }
    
    private func setForwardPlayerButtonImageView() {
        view.addSubview(forwardPlayerButtonImageView)
        forwardPlayerButtonImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(playPausePlayerButtonImageView.snp.centerY)
            make.left.equalTo(playPausePlayerButtonImageView.snp.right).offset(40)
            make.height.width.equalTo(24)
        }
        forwardPlayerButtonImageView.image = UIImage(named: "playerForwardActive")
    }
    
    private func setPlayPausePlayerButton() {
        view.addSubview(playPausePlayerButton)
        playPausePlayerButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(playPausePlayerButtonImageView.snp.centerY)
            make.centerX.equalTo(playPausePlayerButtonImageView.snp.centerX)
            make.height.width.equalTo(64)
        }
        playPausePlayerButton.addTarget(self, action: #selector(playPausePlayerButtonAction), for: .touchUpInside)
    }
    
    private func setBackPlayerButton() {
        view.addSubview(backPlayerButton)
        backPlayerButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(backPlayerButtonImageView.snp.centerY)
            make.centerX.equalTo(backPlayerButtonImageView.snp.centerX)
            make.height.width.equalTo(44)
        }
        backPlayerButton.addTarget(self, action: #selector(playerBackButtonAction), for: .touchUpInside)
    }
    
    private func setForwardPlayerButton() {
        view.addSubview(forwardPlayerButton)
        forwardPlayerButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(forwardPlayerButtonImageView.snp.centerY)
            make.centerX.equalTo(forwardPlayerButtonImageView.snp.centerX)
            make.height.width.equalTo(44)
        }
        forwardPlayerButton.addTarget(self, action: #selector(forwardPlayerButtonAction), for: .touchUpInside)
    }
    
    
    private func setSubtitleLabel() {
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(playPausePlayerButtonImageView.snp.top).offset(-40)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.Basic.latoBold(size: 18)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        subtitleLabel.text = "Социальные проблемы"
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-7)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.Basic.latoNormal(size: 24)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Страх выступать публично"
    }
    
    
}

// MARK: - PlayerProtocol

extension PlayerViewController: PlayerProtocol {
    
}
