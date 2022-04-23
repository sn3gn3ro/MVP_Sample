//
//  SearchMainTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 03.02.2022.
//

import UIKit

protocol SearchMainTableCellDelegate: AnyObject {
    func didPressedBackButton()
    func didChangeSearchText(text: String)
}


class SearchMainTableCell: UITableViewCell {
    
    let backImageView = UIImageView()
    let backButtonView = SquareRoundButtonView(type: .backArrow)
    let searchView = SearchView(placeholderText: CommonString.searchPlaceholder)
    
    weak var delegate: SearchMainTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setBackImageView()
        setBackButtonView()
        setSearchView()
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
    
    func setData() {
        backImageView.image = UIImage(named: "backNightTest")
    }
    
    //MARK: - Private
    
    private func setBackImageView() {
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.height.equalTo(260)
        }
    }
    
    private func setBackButtonView() {
        contentView.addSubview(backButtonView)
        backButtonView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
        }
        backButtonView.setBackColor(color: UIColor.Main.primaryViolet.withAlphaComponent(0.2))
        backButtonView.buttonPressed = {
            self.delegate?.didPressedBackButton()
        }
    }
    
    private func setSearchView() {
        contentView.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(backImageView.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(48)
            make.bottom.equalToSuperview().offset(-20)
        }
        searchView.delegate = self
       
    }
    
    
}

//MARK: - SearchViewDelegate

extension SearchMainTableCell: SearchViewDelegate {
    func didChangeSearchText(text: String) {
        delegate?.didChangeSearchText(text: text)
    }
}
