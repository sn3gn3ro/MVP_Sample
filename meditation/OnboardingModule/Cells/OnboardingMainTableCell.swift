//
//  OnboardingMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit

protocol OnboardingMainTableCellDelegate: AnyObject {
    func didEndSelection(ids: [Int])
}

class OnboardingMainTableCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .bar)
    private let customScrollView = CustomScrollView()
    private var scrollViews = [UIView]()
    private var selecedIds = [Int:[Int]]()
    
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
    
    func setData(questionsListModel: QuestionsListModel) {
        scrollViews.removeAll()
        guard let data = questionsListModel.data else { return }
        for (index,element) in data.enumerated() {
            if element.multiple == 0 {
                setSelectBenweenTwoView(index: index, element: element, isLast: index == data.count - 1)
            } else {
                setMultipleView(index: index, element: element, isLast: index == data.count - 1)
            }
        }
        progressView.setProgress(Float(1) / Float(self.scrollViews.count), animated: true)
        titleLabel.text = "\(1) \(CommonString.questionOutOf) \(scrollViews.count)-х"
        customScrollView.setViews(views: scrollViews)
    }

    
    private func setSelectBenweenTwoView(index: Int, element: QuestionsListDataModel, isLast:Bool) {
        let view = OnboardViewSelectionBetweenTwo()
        view.setData(data: element, index: index, isLast: isLast)
        view.didPressedFurther = { [weak self] selectedImage, index, isLast in
            guard let `self` = self else { return }
            guard let selectedId = selectedImage?.id else { return }
            self.selecedIds[index] = [selectedId]
            if isLast {
                self.delegate?.didEndSelection(ids: self.selecedIds.values.flatMap({$0}))
            } else {
                self.customScrollView.scrollToNextScreen()
            }
        }
        
        view.didPressedBack = {
            self.customScrollView.scrollToPreviousScreen()
        }
        
        scrollViews.append(view)
    }
    
    private func setMultipleView(index: Int, element: QuestionsListDataModel, isLast:Bool) {
        let view = EmotionsWorkView()
        view.setData(data: element, isLast: isLast, index:  index)
        view.didPressedFurther = { [weak self] ids, index, isLast in
            guard let `self` = self else { return }
            guard let ids = ids else { return }
            self.selecedIds[index] = ids.map({$0.id ?? 0})
            if isLast {
                self.delegate?.didEndSelection(ids: self.selecedIds.values.flatMap({$0}))
            } else {
                self.customScrollView.scrollToNextScreen()
            }
        }
        
        view.didPressedBack = {
            self.customScrollView.scrollToPreviousScreen()
        }
        
        scrollViews.append(view)
    }
    
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
    }
}

//MARK: - CustomScrollViewDelegate

extension OnboardingMainTableCell: CustomScrollViewDelegate {
    
    func didScrollToNextPage(page: CGFloat) {
        self.isUserInteractionEnabled = false
        self.progressView.setProgress(Float(Float(page) / Float(self.scrollViews.count)), animated: true)
    }
    
    func didScrollToPreviousPage(page: CGFloat) {
        self.progressView.setProgress(Float(Float(page) / Float(self.scrollViews.count)), animated: true)
    }
    
    func didEndScrolling() {
        self.isUserInteractionEnabled = true
    }
}



