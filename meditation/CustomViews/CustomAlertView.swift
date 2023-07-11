//
//  CustomAlertView.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import UIKit

class CustomAlertView: UIView {
    
    struct Button {
        var title: String
        var action: (()->())
    }
    
    let backButton = UIButton()
    let contentView = UIView()
    let closeButtonImageView = UIImageView()
    let closeButton = UIButton()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let actionButton = UIButton()
    
    var isButtonAdded = false
    var buttonPressed:(() -> Void)?
    
    init(title: String, subtitle: String?, button: Button?) {
        super.init(frame: CGRect.zero)
        clipsToBounds = true

        titleLabel.text = title
        subtitleLabel.text = subtitle
        actionButton.setTitle(button?.title, for: .normal)
        isButtonAdded = button != nil
        
        buttonPressed = button?.action
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        setSelf()
        setBackButton()
        setContentView()
        setCloseButtonImageView()
        setCloseButton()
        setTitleLabel()
        setSubtitleLabel()
        setActionButton()
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
    
    @objc private func buttonAction() {
        buttonPressed?()
        hide()
    }
    
    private func setSelf() {
        snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backgroundColor = UIColor.Main.alertBackground.withAlphaComponent(0.7)
    }
    
    private func setBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    private func setContentView() {
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        contentView.backgroundColor = UIColor.Main.primaryViolet
        contentView.layer.cornerRadius = 20
    }
    
    private func setCloseButtonImageView() {
        contentView.addSubview(closeButtonImageView)
        closeButtonImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(14)
            make.top.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-19)
        }
        closeButtonImageView.image = UIImage(named: "whiteCross")
    }
    
    private func setCloseButton() {
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(closeButtonImageView.snp.centerY)
            make.centerX.equalTo(closeButtonImageView.snp.centerX)
            make.height.width.equalTo(50)
        }
        closeButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.Basic.latoNormal(size: 22)
        titleLabel.textColor = .white
    }
    
    private func setSubtitleLabel() {
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        subtitleLabel.textAlignment = .left
        subtitleLabel.font = UIFont.Basic.latoNormal(size: 14)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
    }
    
    private func setActionButton() {
        contentView.addSubview(actionButton)
        actionButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-20)
            if isButtonAdded {
                make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
                make.height.equalTo(50)
                
            } else {
                make.top.equalTo(subtitleLabel.snp.bottom)
                make.height.equalTo(0)
            }
        }
        actionButton.layer.cornerRadius = 20
        actionButton.backgroundColor = UIColor.Main.borderViolet
        actionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}
