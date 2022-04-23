//
//  PlayerTrackView.swift
//  meditation
//
//  Created by Ilya Medvedev on 28.01.2022.
//

import UIKit

class PlayerTrackView: UIView {
    
    private let slider = UISlider()
    private let startTime = UILabel()
    private let endTime = UILabel()
    
    
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
    
    func setData() {
        startTime.text = "2:30"
        endTime.text = "18:00"
        slider.setValue(0.4, animated: false)
    }
    
    // MARK: - Private Actions
    
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
        startTime.text = "2:30"
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
        endTime.text = "18:00"
    }
  
}
