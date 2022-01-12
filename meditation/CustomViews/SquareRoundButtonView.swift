//
//  SquareRoundButtonView.swift
//  meditation
//
//  Created by Ilya Medvedev on 27.12.2021.
//

import UIKit

class SquareRoundButtonView: UIView {
    
    enum DataType {
        case backArrow
        
        func image() -> UIImage {
            switch self {
                case .backArrow:
                    return UIImage(named: "leftWhiteNormalArrow") ?? UIImage()
            }
        }
    }
    
    private let dataImageView = UIImageView()
    private let button = UIButton()
    
    var buttonPressed:(()->())?
    
    var currentType: DataType = .backArrow
    
    init(type:DataType) {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
        
        currentType = type
        dataImageView.image = type.image()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        setSelf()
        setDataImageView()
        setButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Actions

    func setbackColor(color: UIColor) {
        self.backgroundColor = color
    }
    
    // MARK: - Private
    
    @objc private func didPressedButton() {
        buttonPressed?()
    }
    
    private func setSelf() {
        snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
        }
        layer.cornerRadius = 12
        self.backgroundColor = UIColor.Main.darkViolet
    }
    
    private func setDataImageView() {
        addSubview(dataImageView)
        dataImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(26)
        }
    }
    
    private func setButton() {
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        button.addTarget(self, action: #selector(didPressedButton), for: .touchUpInside)
    }
}



