//
//  SMSCodeView.swift
//  meditation
//
//  Created by Ilya Medvedev on 27.12.2021.
//

import UIKit

public protocol OTPViewDelegate {
    func didBeginEdit()
    func didFinishedEnterOTP(otpNumber: String)
    func otpNotValid()
}

 class OTPInputView: UIView {
    
    @IBInspectable var maximumDigits: Int = 6
//    @IBInspectable var backgroundColour: UIColor = UIColor.Main.darkViolet
    @IBInspectable var shadowColour: UIColor = .darkGray
    @IBInspectable var textColor: UIColor = .white
    @IBInspectable var font: UIFont = UIFont.Basic.latoNormal(size: 20)
    
    public var delegateOTP: OTPViewDelegate?
    
    private var textFields = [UITextField]()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        setupTextFields()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setErrorStyle() {
        textFields.forEach({$0.layer.borderColor = UIColor.Main.errorRed.cgColor})
    }
    
    func setNormalStyle() {
        textFields.forEach({$0.layer.borderColor = UIColor.Main.borderViolet.cgColor})
    }
    
    
    fileprivate func setupTextFields() {
        backgroundColor = .clear
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        for tag in 1...maximumDigits {
            let textField = OTPTextField()
            textField.tag = tag //set Tag to textField
            stackView.addArrangedSubview(textField)  // Add to stackView
            textFields.append(textField)
            setupTextFieldStyle(textField)  // set the style accordingly
        }
    }
    
    fileprivate func setupTextFieldStyle(_ textField: UITextField) {
        textField.delegate = self // set up textfield delegate
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.contentHorizontalAlignment = .center
        textField.backgroundColor = UIColor.Main.darkViolet
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.Main.borderViolet.cgColor
        textField.layer.cornerRadius = 16
//        textField.dropShadow(shadowOpacity: 0.6, shadowColor: shadowColour)
        textField.textColor = textColor
        textField.font = font
    }
}

extension OTPInputView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var nextTag = 0
        if string.checkBackspace() {
            textField.deleteBackward()
            return false
        } else if string.count == 1
        {
            textField.text = string
            nextTag = textField.tag + 1
        } else if string.count == maximumDigits
        {
            var otpPasted = string
            for tag in 1...maximumDigits {
                guard let textfield = viewWithTag(tag) as? UITextField else { continue }
                textfield.text = String(otpPasted.removeFirst())
            }
            otpFetch()
        }
        
        if let nextTextfield = viewWithTag(nextTag) as? OTPTextField {
            nextTextfield.becomeFirstResponder()
        } else {
            if nextTag > maximumDigits {
                otpFetch()
            }
            endEditing(true)
        }
        return false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegateOTP?.didBeginEdit()
    }
    
    
    public func otpFetch() {
        var otp = ""
        for tag in 1...maximumDigits {
            guard let textfield = viewWithTag(tag) as? UITextField else { continue }
            otp += textfield.text!
        }
        
        // Check if OTP is complete, i.e equals to maxDigits allowed
        if otp.count == maximumDigits {
            delegateOTP?.didFinishedEnterOTP(otpNumber: otp)
        } else {
            delegateOTP?.otpNotValid()
        }
    }

}

extension String {
    func checkBackspace() -> Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
            return false
        }
        return false
    }
}

extension UIView {
    func dropShadow( shadowRadius: CGFloat = 2.0, offsetSize: CGSize = CGSize(width: 2, height: 5), shadowOpacity: Float = 0.5, shadowColor: UIColor = UIColor.lightGray ) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = offsetSize
        layer.shadowRadius = shadowRadius
    }
    
}

