//
//  DataEnterView.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit

class DataEnterView: UIView {
    
    enum DataType {
        case email
        case password
        case name
        case phone
        
        func image() -> UIImage {
            switch self {
                case .email:
                    return UIImage(named: "email") ?? UIImage()
                case .password:
                    return UIImage(named: "lock") ?? UIImage()
                case .name:
                    return UIImage(named: "user") ?? UIImage()
                case .phone:
                    return UIImage(named: "phone") ?? UIImage()
            }
        }
        
        func placeholder() -> String {
            switch self {
                case .email:
                    return CommonString.email
                case .password:
                    return CommonString.password
                case .name:
                    return CommonString.name
                case .phone:
                    return CommonString.phone
            }
        }
    }
    
    enum State {
        case initial
        case typing
        case filled
        case disabled
        case success
        case error
    }
    
    private let backView = UIView()
    private let dataImageView = UIImageView()
    private let dataTextField = UITextField()
    private let checkImageView = UIImageView()
    private let errorLabel = UILabel()
    
    var dataEndEditing:((String)->())?
    var dataBeginEditing:((String)->())?
    
    private var enteredPhone = ""
    private var currentType: DataType = .name
    
    var state: State = .initial
    var isDataValidate = false
    
    init(type:DataType) {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
        
        currentType = type
        dataImageView.image = type.image()
        
       
        setStyle(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        UITextField.appearance().tintColor = UIColor.Main.borderViolet
        
        setSelf()
        setBackView()
        setErrorLabel()
        setDataImageView()
        setDataTextField()
        setCheckImageView()
        
        setInitialState()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - States
    
    func getText() -> String? {
        return dataTextField.text
    }
    
    func setData(text: String?) {
        if currentType == .phone {
            guard let text = text else { return }
            dataTextField.text! = formattedNumber(number: text)
        } else {
            dataTextField.text = text
        }
    }
    
    func setDisabledState() {
        backView.layer.borderWidth = 0
        backView.layer.borderColor = UIColor.Main.borderViolet.cgColor
        dataTextField.attributedPlaceholder = NSAttributedString(
            string: currentType.placeholder(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Main.grayViolet.withAlphaComponent(0.6)]
        )
        dataImageView.tintColor = UIColor.Main.grayViolet
        checkImageView.isHidden = true
        errorLabel.isHidden = true
    }
    
    func setSuccessState() {
        backView.layer.borderWidth = 0
        backView.layer.borderColor = UIColor.Main.borderViolet.cgColor
        dataTextField.attributedPlaceholder = NSAttributedString(
            string: currentType.placeholder(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        dataImageView.tintColor = UIColor.Main.borderViolet
        checkImageView.isHidden = false
        errorLabel.isHidden = true
    }
    
    func setErrorState(errorText: String) {
        backView.layer.borderWidth = 2
        backView.layer.borderColor = UIColor.Main.errorRed.cgColor
        dataTextField.attributedPlaceholder = NSAttributedString(
            string: currentType.placeholder(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        dataImageView.tintColor = UIColor.Main.borderViolet
        checkImageView.isHidden = true
        errorLabel.isHidden = false
        errorLabel.text = errorText
    }
    
    func setInitialState() {
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.Main.borderViolet.cgColor
        dataTextField.attributedPlaceholder = NSAttributedString(
            string: currentType.placeholder(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        dataImageView.tintColor = UIColor.Main.borderViolet
        checkImageView.isHidden = true
        errorLabel.isHidden = true
    }
    
    private func setTypingState() {
        backView.layer.borderWidth = 2
        backView.layer.borderColor = UIColor.Main.borderViolet.cgColor
        dataTextField.attributedPlaceholder = NSAttributedString(
            string: currentType.placeholder(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        dataImageView.tintColor = UIColor.Main.borderViolet
        checkImageView.isHidden = true
        errorLabel.isHidden = true
    }
    
    private func setFilledState() {
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.Main.borderViolet.cgColor
        dataTextField.attributedPlaceholder = NSAttributedString(
            string: currentType.placeholder(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        dataImageView.tintColor = UIColor.Main.borderViolet
        checkImageView.isHidden = true
        errorLabel.isHidden = true
    }
    
    // MARK: - Private Actions
    
    @objc private func didBeginEditing() {
        dataBeginEditing?(dataTextField.text ?? "")
        setTypingState()
    }
    
    @objc private func didChangeEditing() {
        if currentType == .phone {
            dataTextField.text! = formattedNumber(number: dataTextField.text!)
        }
    }
    
    @objc private func didEndEditing() {
        setFilledState()
        if currentType == .phone {
            phoneEndEditing()
        } else if currentType == .email {
            emailEndEditing()
        } else {
            dataEndEditing?(dataTextField.text!)
        }
    }
    
    private func phoneEndEditing() {
        if enteredPhone.count == 11 {
//            enteredPhone.removeLast()
            setSuccessState()
            isDataValidate = true
        } else {
            isDataValidate = false
            setErrorState(errorText: CommonString.thisNumberDoesntExist)
        }
        dataEndEditing?(enteredPhone)
    }
    
    private func emailEndEditing() {
        if dataTextField.text!.isValidEmail() {
            setSuccessState()
            isDataValidate = true
        } else {
            isDataValidate = false
//                setErrorState(errorText: "Неправильный email")
        }
        dataEndEditing?(dataTextField.text!)
    }
    
    private func setStyle(type:DataType) {
        switch type {
            case .email:
                dataTextField.keyboardType = .emailAddress
            case .password:
                dataTextField.keyboardType = .default
                dataTextField.isSecureTextEntry = true
            case .name:
                dataTextField.keyboardType = .default
            case .phone:
                dataTextField.keyboardType = .numberPad
        }
    }
    
    // MARK: - makeConstraints
    
    private func setSelf() {
        snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(70)
        }
    }
    
    private func setBackView() {
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(52)
        }
        backView.layer.cornerRadius = 20
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.Main.borderViolet.cgColor
        backView.backgroundColor = UIColor.Main.darkViolet
    }
    
    private func setErrorLabel() {
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backView.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(16)
        }
        errorLabel.font = UIFont.Basic.latoNormal(size: 12)
        errorLabel.textColor = UIColor.Main.errorRed
        
    }
    
    private func setDataImageView() {
        backView.addSubview(dataImageView)
        dataImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(18)
        }
    }
    
    private func setDataTextField() {
        backView.addSubview(dataTextField)
        dataTextField.snp.makeConstraints { (make) in
            make.left.equalTo(dataImageView.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-44)
        }
       
        dataTextField.addTarget(self, action: #selector(didChangeEditing), for: .editingChanged)
        dataTextField.addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        dataTextField.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
        dataTextField.font = UIFont.Basic.latoNormal(size: 16)
        dataTextField.textColor = .white
    }
    
    private func setCheckImageView() {
        backView.addSubview(checkImageView)
        checkImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
        checkImageView.image = UIImage(named: "checkGreen")
    }
    
    
    private func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if cleanPhoneNumber.count <= 11 {
            enteredPhone = cleanPhoneNumber
        }
        
        let mask = "+X (XXX) XXX-XX-XX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}


