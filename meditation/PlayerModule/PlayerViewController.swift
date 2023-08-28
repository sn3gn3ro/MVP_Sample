//
//  PlayerViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.01.2022.
//

import UIKit
import AVFoundation

protocol PlayerViewControllerDelegate: AnyObject {
    func didRemoveFromFavorites(index: Int)
}

class PlayerViewController: UIViewController {
    
    private let videoContainerView = UIView()
    private var player: AVPlayer?
    private var audioPlayer: AVAudioPlayer?
    private var playerLayer: AVPlayerLayer?
    
    private let backButton = SquareRoundButtonView(type: .backArrow)
    private let heartButton = SquareRoundButtonView(type: .heart)
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let playPausePlayerButtonImageView = UIImageView()
    private let backPlayerButtonImageView = UIImageView()
    private let forwardPlayerButtonImageView = UIImageView()
    
    
    private let playPausePlayerButton = UIButton()
    private let backPlayerButton = UIButton()
    private let forwardPlayerButton = UIButton()
    
    private let playerTrackView = PlayerTrackView()
    private let activityView = UIActivityIndicatorView()
    private var updater: CADisplayLink?
    
    var presenter: PlayerPresenter?

    weak var delegate: PlayerViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        presenter?.getLessonInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter?.setListenedLesson(durationSeconds: Int(audioPlayer?.currentTime ?? 0), isFinishLesson: 0)
        audioPlayer?.stop()
        updater?.invalidate()
    }
    
    deinit {
        audioPlayer?.stop()
        print()
    }
    

    // MARK: - Private
    
    @objc private func playPausePlayerButtonAction() {
        guard let audioPlayer = audioPlayer else { return }
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            playPausePlayerButtonImageView.image = UIImage(named: "playerPlay")
        } else {
            audioPlayer.play()
            playPausePlayerButtonImageView.image = UIImage(named: "playerPause")
        }
      
    }
    
    @objc private func playerBackButtonAction() {
        presenter?.dataModel.changeCurrentLesson(changeDirection: .back)
        preparePlayer()
        presenter?.getLessonInfo()
    }
    
    @objc private func forwardPlayerButtonAction() {
        presenter?.dataModel.changeCurrentLesson(changeDirection: .forvard)
        preparePlayer()
        presenter?.getLessonInfo()
    }
    
    private func configure() {
        setVideoContainerView()
        setBackButton()
        setHeartButton()

        setPlayerTrackView()
        setActivityView()
        setPlayPausePlayerButtonImageView()
        setBackPlayerButtonImageView()
        setForwardPlayerButtonImageView()

        setPlayPausePlayerButton()
        setBackPlayerButton()
        setForwardPlayerButton()

        setSubtitleLabel()
        setTitleLabel()
        
        preparePlayer()
    }
    
    private func preparePlayer() {
        audioPlayer?.stop()
        playerTrackView.isHidden = true
        activityView.startAnimating()
        guard let presenter = presenter else { return }
        if presenter.dataModel.isNextLessonExist() {
            forwardPlayerButtonImageView.image = UIImage(named: "playerForwardActive")
            forwardPlayerButton.isUserInteractionEnabled = true
        } else {
            forwardPlayerButtonImageView.image = UIImage(named: "playerForwardUnactive")
            forwardPlayerButton.isUserInteractionEnabled = false
        }
        
        if presenter.dataModel.isPreviousLessonExist(){
            backPlayerButtonImageView.image = UIImage(named: "playerBackActive")
            backPlayerButton.isUserInteractionEnabled = true
        } else {
            backPlayerButtonImageView.image = UIImage(named: "playerBackUnactive")
            backPlayerButton.isUserInteractionEnabled = false
        }
    }
    
    private func setVideoContainerView() {
        view.addSubview(videoContainerView)
        videoContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        videoContainerView.backgroundColor = UIColor.Main.darkViolet
    }

    private func setBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(16)
        }
        backButton.setBackColor(color: UIColor.Main.primaryViolet.withAlphaComponent(0.2))
        backButton.buttonPressed = { [weak self] in
            self?.dismiss(animated: true)
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setHeartButton() {
        view.addSubview(heartButton)
        heartButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-16)
        }
        heartButton.isHidden = true
        heartButton.setBackColor(color: UIColor.Main.primaryViolet.withAlphaComponent(0.2))
        heartButton.buttonPressed = { [weak presenter] in
            presenter?.changeFavoriteState()
        }
    }
    
    private func setPlayerTrackView() {
        view.addSubview(playerTrackView)
        playerTrackView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-60)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
        playerTrackView.delegate = self
        playerTrackView.isHidden = true
    }
    
    private func setActivityView() {
        view.addSubview(activityView)
        activityView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(playerTrackView)
            make.height.width.equalTo(22)
        }
        activityView.hidesWhenStopped = true
        activityView.color = .white
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
       
    }
    
    private func setForwardPlayerButtonImageView() {
        view.addSubview(forwardPlayerButtonImageView)
        forwardPlayerButtonImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(playPausePlayerButtonImageView.snp.centerY)
            make.left.equalTo(playPausePlayerButtonImageView.snp.right).offset(40)
            make.height.width.equalTo(24)
        }

       
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
        
    }
}

// MARK: - PlayerTrackViewDelegate

extension PlayerViewController: PlayerTrackViewDelegate {
    func didChangeValue(progress: Float) {
        guard let audioPlayer = audioPlayer else { return }
        let isPlaying = audioPlayer.isPlaying
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(progress)
        audioPlayer.prepareToPlay()
        if isPlaying {
            audioPlayer.play()
        }
    }
}

// MARK: - AVAudioPlayerDelegate

extension PlayerViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        presenter?.setListenedLesson(durationSeconds: 0, isFinishLesson: 1)
        if presenter?.dataModel.isNextLessonExist() ?? false {
            forwardPlayerButtonAction()
        }
    }
}

// MARK: - PlayerProtocol

extension PlayerViewController: PlayerProtocol {
    func didListedAllLessons() {
        ModuleRouter.showCongratulationModule(currentViewController: self)
    }
    
    func didGetLesson() {
        heartButton.isHidden = false
        titleLabel.text = presenter?.dataModel.lesson?.name//"Страх выступать публично"
        subtitleLabel.text = presenter?.dataModel.sectionName ?? ""//"Социальные проблемы"
        guard let isFavorite = presenter?.dataModel.lesson?.favorite else { return }
        if isFavorite {
            heartButton.setSelectedState()
        } else {
            heartButton.setNormalState()
        }
    }
    
    func didLoadVideo(url: URL) {
        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame =  videoContainerView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoContainerView.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { [weak player] _ in
            player?.seek(to: CMTime.zero)
            player?.play()
        }
        player?.isMuted = true
        player?.play()
    }
    
    func didLoadAudio(data: Data) {
        playerTrackView.isHidden = false
        activityView.stopAnimating()
        audioPlayer = try? AVAudioPlayer(data: data)
        audioPlayer?.prepareToPlay()
        audioPlayer?.delegate = self
        playerTrackView.setData(duration: Float(audioPlayer?.duration ?? 0))
        updater = CADisplayLink(target: self, selector: #selector(trackAudio))
        updater?.preferredFramesPerSecond = 1
        updater?.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
        playPausePlayerButtonImageView.image = UIImage(named: "playerPause")
        let startDelay: TimeInterval = TimeInterval(presenter?.dataModel.lesson?.durationSeconds ?? 0)
        audioPlayer?.currentTime = startDelay
        audioPlayer?.play()
//        audioPlayer?.play()
    }
    
    @objc func trackAudio() {
        guard let audioPlayer = audioPlayer else { return }
        playerTrackView.updateProgress(progress: Float(audioPlayer.currentTime))
    }
    
    func didChangeIsFavoriteState(isFavorite: Bool) {
        if isFavorite {
            heartButton.setSelectedState()
        } else {
            heartButton.setNormalState()
        }
    }
}
