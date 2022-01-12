//
//  SimpleTextButtonView.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit

class SimpleTextButtonView: UIView {
    
    enum StateType {
        case normal
        case unactive
        case bordered
        
        func backgroundColor() -> UIColor {
            switch self {
                case .normal:
                    return UIColor.Main.borderViolet
                case .unactive:
                    return UIColor.Main.grayViolet
                case .bordered:
                    return UIColor.clear
            }
        }
        
        func textColor() -> UIColor {
            switch self {
                case .normal:
                    return UIColor.Main.darkWhite
                case .unactive:
                    return UIColor.Main.lightGray
                case .bordered:
                    return UIColor.Main.darkWhite
            }
        }
    }
    
    let buttonTextLabel = UILabel()
    let button = UIButton()
    
    var buttonAction:(()->())?
    
    init(type:StateType, text: String) {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
        
        buttonTextLabel.text = text
        setStyle(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        setSelf()
        setButtonTextLabel()
        setButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Actions
    
    @objc func mainButtonAction() {
        buttonAction?()
    }
    
    func setStyle(type:StateType) {
        switch type {
            case .normal:
                layer.borderWidth = 0
                layer.borderColor = UIColor.clear.cgColor
                self.isUserInteractionEnabled = true
            case .unactive:
                layer.borderWidth = 0
                layer.borderColor = UIColor.clear.cgColor
                self.isUserInteractionEnabled = false
            case .bordered:
                layer.borderWidth = 1
                layer.borderColor = UIColor.Main.borderViolet.cgColor
                self.isUserInteractionEnabled = true
        }
        backgroundColor = type.backgroundColor()
        buttonTextLabel.textColor = type.textColor()
    }
    
    // MARK: - Private
    
    private func setSelf() {
        snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        layer.cornerRadius = 20
        
    }
    
    private func setButtonTextLabel() {
        addSubview(buttonTextLabel)
        buttonTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        buttonTextLabel.font = UIFont.Basic.latoBold(size: 16)
        buttonTextLabel.textColor = .white
    }
    
    private func setButton() {
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        button.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
    }
    
}



