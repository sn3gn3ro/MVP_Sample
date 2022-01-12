//
//  RegistrationButtonView.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit

class RegistrationButtonView: UIView {
    
    enum RegistrationType {
        case google
        case apple
        case phone
        
        func image() -> UIImage {
            switch self {
                case .google:
                    return UIImage(named: "google") ?? UIImage()
                case .apple:
                    return UIImage(named: "apple") ?? UIImage()
                case .phone:
                    return UIImage(named: "phoneRegistration") ?? UIImage()
            }
        }
    }
    
    let buttonImageView = UIImageView()
    let button = UIButton()
    
    var buttonAction:(()->())?
    
    init(type:RegistrationType) {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
        
        buttonImageView.image = type.image()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        setSelf()
        setButtonImageView()
        setButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Actions
    
    @objc func mainButtonAction() {
        buttonAction?()
    }
    
    // MARK: - Private
    
    private func setSelf() {
        snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
        }
        layer.cornerRadius = 25
        backgroundColor = .white
    }
    
    private func setButtonImageView() {
        addSubview(buttonImageView)
        buttonImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(22)
        }
    }
    
    private func setButton() {
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        button.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
    }
    
}




