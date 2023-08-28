//
//  VideoPlayerView.swift
//  meditation
//
//  Created by Ilya Medvedev on 17.08.2023.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    private var player: AVPlayer?
    private var playerLayer =  AVPlayerLayer()
    
    init() {
        super.init(frame: .zero)
    }
    
    deinit {
        print()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

    }
    
    func didLoadVideo(url: URL) {
        playerLayer.removeFromSuperlayer()
        player = AVPlayer(url: url)
        player?.isAccessibilityElement  = false
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame =  self.bounds
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        player?.isMuted = true
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { [weak player] _ in
            player?.seek(to: CMTime.zero)
            player?.play()
        }
        player?.play()
    }
}
