//
//  OnboardingMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit

protocol OnboardingMainTableCellDelegate: AnyObject {
    func didSelectPanic(isPositive: Bool)
    func didSelectRelashionshipProblem(isPositive: Bool)
    func didSelectHealthFear(isPositive: Bool)
    func didSelectEmotions(emotions: [EmotionsWorkView.EmotionModel])
}

class OnboardingMainTableCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let progressView = UIProgressView(progressViewStyle: .bar)
    let customScrollView = CustomScrollView()
    let panicView = PanicAttackView()
    let relationshipProblemView = RelationshipProblemView()
    let healthFearView = HealthFearView()
    let emotionsWorkView = EmotionsWorkView()
//    let backButtonView =  SimpleTextButtonView(type: .bordered, text: CommonString.back)
//    let furtherButtonView =  SimpleTextButtonView(type: .normal, text: CommonString.further)
    
    var scrollViews:[UIView]  {
        return [panicView,relationshipProblemView,healthFearView,emotionsWorkView]
    }
    
    enum Const {
        //78 + 22 + 12 + 18 + 30
        static let titleTopOffset: CGFloat = 78
        static let titleHeight: CGFloat = 22
        static let progressViewTopOffset: CGFloat = 12
        static let progressViewHeight: CGFloat = 18
        static let customScrollViewTopOffset: CGFloat = 30
    }
    
    weak var delegate: OnboardingMainTableCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.backgroundColor = .clear
        
        setTitleLabel()
        setProgressView()
        setScrollView()        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    //MARK: - Actions

    
    //MARK: - Private
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(78)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(22)
        }
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.Basic.latoNormal(size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "\(1) \(CommonString.questionOutOf) \(scrollViews.count)-х"
    }
    
    private func setProgressView() {
        contentView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }
        progressView.progressTintColor = UIColor.Main.darkViolet
        progressView.trackTintColor =  UIColor.Main.borderViolet
        progressView.setProgress(Float(1) / Float(self.scrollViews.count), animated: true)
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true
    }
    
    private func setScrollView() {
        contentView.addSubview(customScrollView)
        customScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(progressView.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height - (Const.titleTopOffset + Const.titleHeight + Const.progressViewTopOffset + Const.progressViewHeight + Const.customScrollViewTopOffset))//652
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        customScrollView.delegate = self
        customScrollView.setViews(views: scrollViews)
        
        panicView.didPressedFurther = { isPositive in
            self.delegate?.didSelectPanic(isPositive: isPositive)
            self.customScrollView.scrollToNextScreen()
        }
        
        panicView.didPressedBack = {
            self.customScrollView.scrollToPreviousScreen()
        }
        
        relationshipProblemView.didPressedFurther = { isPositive in
            self.delegate?.didSelectRelashionshipProblem(isPositive: isPositive)
            self.customScrollView.scrollToNextScreen()
        }
        
        relationshipProblemView.didPressedBack = {
            self.customScrollView.scrollToPreviousScreen()
        }
        
        healthFearView.didPressedFurther = { isPositive in
            self.delegate?.didSelectHealthFear(isPositive: isPositive)
            self.customScrollView.scrollToNextScreen()
        }
        
        healthFearView.didPressedBack = {
            self.customScrollView.scrollToPreviousScreen()
        }
        
        emotionsWorkView.didPressedFurther = { emotions in
            self.delegate?.didSelectEmotions(emotions: emotions)
        }
        
        emotionsWorkView.didPressedBack = {
            self.customScrollView.scrollToPreviousScreen()
        }
    }
}

//MARK: - CustomScrollViewDelegate

extension OnboardingMainTableCell: CustomScrollViewDelegate {
    
    func didScrollToNextPage(page: CGFloat) {
        self.progressView.setProgress(Float(Float(page) / Float(self.scrollViews.count)), animated: true)
    }
    
    func didScrollToPreviousPage(page: CGFloat) {
        self.progressView.setProgress(Float(Float(page) / Float(self.scrollViews.count)), animated: true)
    }
}



