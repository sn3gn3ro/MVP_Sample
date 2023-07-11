//
//  ConnectionErrorView.swift
//  meditation
//
//  Created by Ilya Medvedev on 29.05.2023.
//

import UIKit

class ConnectionErrorView: UIView {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let wifiImageView = UIImageView()
    
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
        
        setSelf()
        setSubtitleLabel()
        setTitleLabel()
        setWifiImageView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Actions

    func show(view: UIView) {
        view.addSubview(self)
    }
    
    @objc func hide() {
        self.removeFromSuperview()
    }
    
    // MARK: - Private
    
    private func setSelf() {
        snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backgroundColor = UIColor.Main.primaryViolet
    }
    
    private func setSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.centerY)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.Basic.latoNormal(size: 16)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = CommonString.connectionError
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.Basic.latoBold(size: 28)
        titleLabel.textColor = .white
        titleLabel.text = CommonString.ups
    }
   
    private func setWifiImageView() {
        addSubview(wifiImageView)
        wifiImageView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        wifiImageView.image = UIImage(named: "noWifi")
    }
}

