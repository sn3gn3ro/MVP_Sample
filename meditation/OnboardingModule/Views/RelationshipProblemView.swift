//
//  RelationshipProblemView.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit

class RelationshipProblemView: UIView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let leftDataImageView = UIImageView()
    private let leftButton = UIButton()
    private let rightDataImageView = UIImageView()
    private let rightButton = UIButton()
    
    private let backButtonView =  SimpleTextButtonView(type: .bordered, text: CommonString.back)
    private let furtherButtonView =  SimpleTextButtonView(type: .unactive, text: CommonString.further)


    var didSelectVariant: ((Bool)->())?
    var didPressedFurther: ((Bool)->())?
    var didPressedBack: (()->())?
    
    var isProblem: Bool?
    
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
        
        UITextField.appearance().tintColor = UIColor.Main.borderViolet
        
        setTitleLabel()
        setSubtitleLabel()
        setleftDataImageView()
        setLeftButton()
        setRightDataImageView()
        setRightButton()
        setBackButton()
        setFurtherButton()
        
        updateImages()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    // MARK: - Private Actions
    
    func updateImages() {
        if isProblem == nil {
            leftDataImageView.image = UIImage(named: "relationshipTrueOff")
            rightDataImageView.image = UIImage(named: "relationshipFalseOff")
        } else if let isProblem = isProblem  {
            leftDataImageView.image = isProblem ? UIImage(named: "relationshipTrueOn") : UIImage(named: "relationshipTrueOff")
            rightDataImageView.image = isProblem ? UIImage(named: "relationshipFalseOff") : UIImage(named: "relationshipFalseOn")
            furtherButtonView.setStyle(type: .normal)
        }
    }
    
    @objc private func leftButtonActiom() {
        isProblem = true
        didSelectVariant?(true)
        updateImages()
    }
    
    @objc private func rightButtonActiom() {
        isProblem = false
        didSelectVariant?(false)
        updateImages()
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(76)
        }
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.Basic.latoBold(size: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.text = CommonString.relationshipTitle
    }
    
    private func setSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(38)
        }
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.Basic.latoNormal(size: 14)
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.text = CommonString.relationshipSubtitle
    }
    
    private func setleftDataImageView() {
        addSubview(leftDataImageView)
        leftDataImageView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(70)
            make.right.equalTo(snp.centerX)
            make.left.equalToSuperview().offset(23)
            make.height.equalTo(leftDataImageView.snp.width)
        }
    }
    
    private func setLeftButton() {
        addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(leftDataImageView)
        }
        leftButton.addTarget(self, action: #selector(leftButtonActiom), for: .touchUpInside)
    }
    
    private func setRightDataImageView() {
        addSubview(rightDataImageView)
        rightDataImageView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(70)
            make.left.equalTo(snp.centerX)
            make.right.equalToSuperview().offset(-23)
            make.height.equalTo(rightDataImageView.snp.width)
        }
    }
    
    
    private func setRightButton() {
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(rightDataImageView)
        }
        rightButton.addTarget(self, action: #selector(rightButtonActiom), for: .touchUpInside)
    }
    
    private func setBackButton() {
        addSubview(backButtonView)
        backButtonView.snp.remakeConstraints { (make) in
//            make.top.equalTo(leftDataImageView.snp.bottom).offset(191)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(leftDataImageView.snp.right)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-60)
        }
        backButtonView.buttonAction = {
            self.didPressedBack?()
        }
    }
    
    private func setFurtherButton() {
        addSubview(furtherButtonView)
        furtherButtonView.snp.remakeConstraints { (make) in
//            make.top.equalTo(rightDataImageView.snp.bottom).offset(191)
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(snp.centerX).offset(7)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-60)
        }
        furtherButtonView.buttonAction = {
            self.didPressedFurther?(self.isProblem ?? false)
        }
    }

}


