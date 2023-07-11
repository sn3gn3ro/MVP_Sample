//
//  OnboardViewSelectionBetweenTwo.swift
//  meditation
//
//  Created by Ilya Medvedev on 20.06.2023.
//

import UIKit

class OnboardViewSelectionBetweenTwo: UIView {
    
    enum SelectedVariant {
        case left
        case right
    }
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let leftDataImageView = UIImageView()
    private let leftButton = UIButton()
    private let rightDataImageView = UIImageView()
    private let rightButton = UIButton()
    private let leftBlurView = UIImageView()
    private let rightBlurView = UIImageView()
    
    private let backButtonView =  SimpleTextButtonView(type: .bordered, text: CommonString.back)
    private let furtherButtonView =  SimpleTextButtonView(type: .unactive, text: CommonString.further)

    var didPressedFurther: ((QuestionsListDataImageModel?,Int, Bool)->())?
    var didPressedBack: (()->())?
    
    var selectedVariant: SelectedVariant?
    var data: QuestionsListDataModel?
    var isLast = false
    var index = 0
        
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
        setLeftBlurView()
        setRightBlurView()
        setBackButton()
        setFurtherButton()
        
        updateImages()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    // MARK: - Private Actions
    
    func setData(data:QuestionsListDataModel, index: Int, isLast: Bool) {
        self.data = data
        self.index = index
        self.isLast = isLast
        titleLabel.text = data.name//CommonString.panicTitle
        subtitleLabel.text = data.description//CommonString.panicSubtitle
        if  let images = data.images {
            if images.count > 0 {
                NetworkManager.getImage(imageUrl: images[0].image ?? "") { [weak self] image in
                    self?.leftDataImageView.image = image //UIImage(named: "panicTrueOff")
                }
            }
            if images.count > 1 {
                NetworkManager.getImage(imageUrl: images[1].image ?? "") { [weak self] image in
                    self?.rightDataImageView.image = image //UIImage(named: "panicFalseOff")
                }
            }
        }
    }
    
    private func furtherButtonViewAction() {
        guard let images = self.data?.images else { return }
        if images.count > 1 {
            var selectedImage: QuestionsListDataImageModel?
            switch self.selectedVariant {
            case .left:
                selectedImage = images[0]
            case .right:
                selectedImage = images[1]
            case .none:
                break
            }
            self.didPressedFurther?(selectedImage, self.index, self.isLast)
        }
    }
    
    private func updateImages() {
        if selectedVariant == nil {
            leftBlurView.alpha = 0
            rightBlurView.alpha = 0
        } else if let selectedVariant = selectedVariant  {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.leftBlurView.alpha = selectedVariant == .left ? 1 :0
                self?.rightBlurView.alpha  = selectedVariant == .left ? 0 : 1
            }
            furtherButtonView.setStyle(type: .normal)
        }
    }
    
    @objc private func leftButtonAction() {
        selectedVariant = .left
        updateImages()
    }
    
    @objc private func rightButtonAction() {
        selectedVariant = .right
        updateImages()
    }
    
    //MARK: - UI
    
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
//        titleLabel.text = CommonString.panicTitle
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
//        subtitleLabel.text = CommonString.panicSubtitle
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
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
    }
    
    private func setLeftBlurView() {
        addSubview(leftBlurView)
        sendSubviewToBack(leftBlurView)
        leftBlurView.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftDataImageView.snp.centerX)
            make.centerY.equalTo(leftDataImageView.snp.centerY)
            make.height.width.equalTo(250)
        }
        leftBlurView.image = UIImage(named: "activeWhiteBlur")
        leftBlurView.alpha = 0
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
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
    }
    
    private func setRightBlurView() {
        addSubview(rightBlurView)
        sendSubviewToBack(rightBlurView)
        rightBlurView.snp.makeConstraints { (make) in
            make.centerX.equalTo(rightDataImageView.snp.centerX)
            make.centerY.equalTo(rightDataImageView.snp.centerY)
            make.height.width.equalTo(250)
        }
        rightBlurView.image = UIImage(named: "activeWhiteBlur")
        rightBlurView.alpha = 0
    }
    
    private func setBackButton() {
        addSubview(backButtonView)
        backButtonView.snp.remakeConstraints { (make) in
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
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(snp.centerX).offset(7)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        furtherButtonView.buttonAction = { [weak self] in
            self?.furtherButtonViewAction()
        }
    }

}



