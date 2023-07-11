//
//  MainSearchTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import UIKit
import SkeletonView

protocol MainSearchTableCellDelegate: AnyObject {
    func searchButtonPressed()
}

class MainSearchTableCell: UITableViewCell {
    
    let happyToSeeLabel = UILabel()
    let nameLabel = UILabel()
    let searchButton =  SquareRoundButtonView(type: .search)
    
    weak var delegate: MainSearchTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        backgroundColor = .clear
       
        isSkeletonable = true
        setHappyToSeeLabel()
        setNameLabel()
        setSearchButton()
      
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
    
    func setData(backgroundColor: UIColor, name: String) {
        self.backgroundColor = backgroundColor
        
        hideSkeleton()
        nameLabel.text = name + "!"
    }
    
    //MARK: - Private
    
    private func setHappyToSeeLabel() {
        contentView.addSubview(happyToSeeLabel)
        happyToSeeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(22)
        }
        happyToSeeLabel.textAlignment = .left
        happyToSeeLabel.font = UIFont.Basic.latoHairline(size: 16)
        happyToSeeLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        happyToSeeLabel.text = CommonString.happyToSeeYou
        happyToSeeLabel.isSkeletonable = true
        happyToSeeLabel.linesCornerRadius = 4
        happyToSeeLabel.skeletonTextLineHeight = SkeletonTextLineHeight.relativeToFont
        happyToSeeLabel.lastLineFillPercent = 20
    }
    
    private func setNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(happyToSeeLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(43)
        }
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.Basic.latoBold(size: 38)
        nameLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        nameLabel.isSkeletonable = true
        nameLabel.linesCornerRadius = 6
        nameLabel.skeletonTextLineHeight = SkeletonTextLineHeight.relativeToFont
    }
    
    private func setSearchButton() {
        contentView.addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-40)
        }
        searchButton.setBackColor(color: UIColor.white.withAlphaComponent(0.3))
        searchButton.buttonPressed = {
            self.delegate?.searchButtonPressed()
        }
        searchButton.isSkeletonable = true
        searchButton.skeletonCornerRadius = 6
    }
    
}

