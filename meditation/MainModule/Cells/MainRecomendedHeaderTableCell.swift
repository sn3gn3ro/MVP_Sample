//
//  MainRecomendedHeaderTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 19.01.2022.
//

import UIKit
import SkeletonView

class MainRecomendedHeaderTableCell: UITableViewCell {
    
    let titleLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        isSkeletonable = true
        setTitleLabel()
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
    
    func setData(text: String) {
        hideSkeleton()
        titleLabel.text = text
    }

    
    //MARK: - Private
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(22)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 18)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        titleLabel.isSkeletonable = true
        titleLabel.text = CommonString.recomendForYou
        titleLabel.linesCornerRadius = 4
        titleLabel.skeletonTextLineHeight = SkeletonTextLineHeight.relativeToFont
//        titleLabel.lastLineFillPercent = 20
    }
}



