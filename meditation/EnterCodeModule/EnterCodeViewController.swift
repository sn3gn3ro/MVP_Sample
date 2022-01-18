//
//  EnterCodeViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 27.12.2021.
//

import UIKit

class EnterCodeViewController: UIViewController {
    
    let starsBackImageView = UIImageView()
    let meditationLogoImageView = UIImageView()
    let backArrowImageView = UIImageView()
    let backArrowButton = UIButton()
    let codeView = OTPInputView()
    let errorTextLabel = UILabel()
    let noCodeLabel = UILabel()
    let sendAgainButton = UIButton()
    
    var presenter:EnterCodePresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        
        setStarsBackImageView()
        setMeditationLogoImageView()
        setBackArrowImageView()
        setBackArrowButton()
        setCodeView()
        setErrorTextLabel()
        setNoCodeLabel()
        setSendAgainButton()
    }
    
    // MARK: - Action
    
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sendAgainButtonAction() {
        
    }
    
    // MARK: - Private
    
    private func setStarsBackImageView() {
        view.addSubview(starsBackImageView)
        starsBackImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(356)
        }
        starsBackImageView.image = UIImage(named: "stars")
    }
    
    private func setMeditationLogoImageView() {
        view.addSubview(meditationLogoImageView)
        meditationLogoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(61)
            make.centerX.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(160)
        }
        meditationLogoImageView.image = UIImage(named: "meditationLogo")
    }
    
    private func setBackArrowImageView() {
        view.addSubview(backArrowImageView)
        backArrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(meditationLogoImageView.snp.centerY)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(22)
            make.width.equalTo(13)
        }
        backArrowImageView.image = UIImage(named: "leftWhiteBoldArrow")
    }
    
    private func setBackArrowButton() {
        view.addSubview(backArrowButton)
        backArrowButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(backArrowImageView.snp.centerY)
            make.centerX.equalTo(backArrowImageView.snp.centerX)
            make.height.width.equalTo(50)
        }
        backArrowButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    private func setCodeView() {
        view.addSubview(codeView)
        codeView.delegateOTP = self
        codeView.snp.makeConstraints { (make) in
            make.top.equalTo(meditationLogoImageView.snp.bottom).offset(58)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(53)
        }
        codeView.maximumDigits = 6
    }
    
    private func setErrorTextLabel() {
        view.addSubview(errorTextLabel)
        errorTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(codeView.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        errorTextLabel.font = UIFont.Basic.latoNormal(size: 12)
        errorTextLabel.textColor = UIColor.Main.errorRed
        errorTextLabel.textAlignment = .left
        errorTextLabel.text = CommonString.youEnterWrongCode
        errorTextLabel.isHidden = true
    }
    
    private func setNoCodeLabel() {
        view.addSubview(noCodeLabel)
        noCodeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(errorTextLabel.snp.bottom).offset(8)
            make.right.equalTo(view.snp.centerX)
        }
        noCodeLabel.font = UIFont.Basic.latoNormal(size: 16)
        noCodeLabel.textColor = .white
        noCodeLabel.text = CommonString.codeDidntCome
    }
    
    private func setSendAgainButton() {
        view.addSubview(sendAgainButton)
        sendAgainButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(noCodeLabel.snp.centerY)
            make.left.equalTo(noCodeLabel.snp.right).offset(8)
        }
        sendAgainButton.titleLabel?.font = UIFont.Basic.latoNormal(size: 16)
        sendAgainButton.setTitleColor(UIColor.Main.lightViolet, for: .normal)
        sendAgainButton.setTitle(CommonString.sendAgain, for: .normal)
        sendAgainButton.addTarget(self, action: #selector(sendAgainButtonAction), for: .touchUpInside)
    }
    
}


extension EnterCodeViewController: OTPViewDelegate {
    
    func didBeginEdit() {
        errorTextLabel.isHidden = true
        codeView.setNormalStyle()
    }
    
    func didFinishedEnterOTP(otpNumber: String) {
        errorTextLabel.isHidden = false
        codeView.setErrorStyle()
    }
    
    func otpNotValid() {
        
    }
}


// MARK: - EnterCodeProtocol

extension EnterCodeViewController: EnterCodeProtocol {
    
}
