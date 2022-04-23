//
//  FavoritesMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import UIKit

protocol FavoritesMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
}


class FavoritesMainTableCell: UITableViewCell {
    
    let backButtonView = SquareRoundButtonView(type: .backArrow)
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    weak var delegate: FavoritesMainTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setИackButtonView()
        setTitleLabel()
        setSubtitleLabel()
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
    
    func setData(isEmpty: Bool) {
        subtitleLabel.text = isEmpty ? CommonString.favoritesSubtitileEmpty : CommonString.favoritesSubtitile
    }

    
    //MARK: - Private
    
    private func setИackButtonView() {
        contentView.addSubview(backButtonView)
        backButtonView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
        }
        backButtonView.buttonPressed = {
            self.delegate?.didPressedBackButton()
        }
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButtonView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(38)
        }
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.Basic.latoNormal(size: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.text = CommonString.favorites
    }
    
    private func setSubtitleLabel() {
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
//            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-30)
        }
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .left
        subtitleLabel.font = UIFont.Basic.latoNormal(size: 16)
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.text = CommonString.favoritesSubtitile
    }
}

