//
//  PlayerTrackView.swift
//  meditation
//
//  Created by Ilya Medvedev on 28.01.2022.
//

import UIKit

protocol PlayerTrackViewDelegate: AnyObject {
    func didChangeValue(progress: Float)
}

class PlayerTrackView: UIView {
    
    private let slider = UISlider()
    private let startTime = UILabel()
    private let endTime = UILabel()
    
    weak var delegate: PlayerTrackViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setSlider()
        setStartTime()
        setEndTime()
    }
    
    // MARK: - States
    
    func setData(duration: Float?) {
        startTime.text = "0:00"
        slider.maximumValue = duration ?? 0
        slider.minimumValue = 0
        guard let duration = duration else { return }
        endTime.text = timeString(time: TimeInterval(duration))
    }
    
    func updateProgress(progress: Float) {
        slider.setValue(progress, animated: true)
        startTime.text = timeString(time: TimeInterval(progress))
    }
    
    // MARK: - Private Actions
    
    private func timeString(time: TimeInterval) -> String {
            let minute = Int(time) / 60 % 60
            let second = Int(time) % 60
            return String(format: "%02i:%02i", minute, second)
    }
    
    @objc private func didChangeSliderValue() {
        delegate?.didChangeValue(progress: slider.value)
    }
    
    private func setSlider() {
        addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        slider.setMaximumTrackImage(UIImage(named: "trackMaximum"), for: .normal)
        slider.setMinimumTrackImage(UIImage(named: "trackMinimum"),  for: .normal)
        let thumbImage = UIImage(named: "thumb")
        slider.setThumbImage(thumbImage, for: .normal)
        slider.setThumbImage(thumbImage, for: .highlighted)
        slider.addTarget(self, action: #selector(didChangeSliderValue), for: .valueChanged)
    }
    
    private func setStartTime() {
        addSubview(startTime)
        startTime.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(18)
            make.bottom.equalToSuperview()
        }
        startTime.textAlignment = .left
        startTime.font = UIFont.Basic.latoNormal(size: 12)
        startTime.textColor = UIColor.Main.textGray
    }
    
    private func setEndTime() {
        addSubview(endTime)
        endTime.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(18)
            make.bottom.equalToSuperview()
        }
        endTime.textAlignment = .right
        endTime.font = UIFont.Basic.latoNormal(size: 12)
        endTime.textColor = UIColor.Main.textGray
    }
  
}
