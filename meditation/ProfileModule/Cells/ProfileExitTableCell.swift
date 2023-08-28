//
//  ProfileExitTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit
import SkeletonView

protocol ProfileExitTableCellDelegate: AnyObject {
    func exitButtonPressed()
}

class ProfileExitTableCell: UITableViewCell {
    
    let exitButtonView = SimpleTextButtonView(type: .bordered, text: CommonString.exit)
    
    weak var delegate: ProfileExitTableCellDelegate?
         
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        isSkeletonable = true
        
        setExitButtonView()
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
        setSkeletonableStyle()
    }
    
    func setData() {
        hideSkeleton()
    }
    
    //MARK: - Private
    
    private func setExitButtonView() {
        contentView.addSubview(exitButtonView)
        exitButtonView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        exitButtonView.buttonAction = { [weak self] in
            self?.delegate?.exitButtonPressed()
        }
//        exitButtonView.setStyle(type: .bordered)
//        exitButtonView.isUserInteractionEnabled = false
        exitButtonView.isSkeletonable = true
//        exitButtonView.skeletonCornerRadius = 20
    }
}
