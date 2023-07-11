//
//  SubscriptionSimpleButtonTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 01.02.2022.
//

import UIKit
import SkeletonView

protocol SubscriptionSimpleButtonTableCellDelegate: AnyObject {
    func didPressedButton()
}

class SubscriptionSimpleButtonTableCell: UITableViewCell {
    
    let simpleTextButtonView = SimpleTextButtonView(type: .normal, text: CommonString.renewCurrentSubscription)
    
    weak var delegate: SubscriptionSimpleButtonTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        isSkeletonable = true
        
        setSimpleTextButtonView()
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
    
    func setSkeleton() {
        simpleTextButtonView.setSkeletonableStyle()
    }
    
    func setData() {
        hideSkeleton()
    }

    
    //MARK: - Private
    
    private func setSimpleTextButtonView() {
        contentView.addSubview(simpleTextButtonView)
        simpleTextButtonView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        simpleTextButtonView.buttonAction = {
            self.delegate?.didPressedButton()
        }
        simpleTextButtonView.isSkeletonable = true
        simpleTextButtonView.skeletonCornerRadius = 25
    }
}




