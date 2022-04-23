//
//  CongratulationBottomTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 28.01.2022.
//

import UIKit

protocol CongratulationBottomTableCellDelegate: AnyObject {
    func didPressedContinue()
}

class CongratulationBottomTableCell: UITableViewCell {
    
    let iconsHorizontalStackView = IconsHorizontalStackView()
    let readersCountLabel = UILabel()
    let readersTextLabel = UILabel()
    let continueButton = SimpleTextButtonView(type: .normal, text: CommonString.continue)
    
    weak var delegate: CongratulationBottomTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setIconsHorizontalStackView()
        setReadersCountLabel()
        setReadersTextLabel()
        setContinueButton()
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
        iconsHorizontalStackView.setData(icons: [URL(string: "http//www.google.com")!,URL(string: "http//www.google.com")!,URL(string: "http//www.google.com")!])
        readersCountLabel.text = "+ \(1359)"
    }
    
    //MARK: - Private
    
    private func setIconsHorizontalStackView() {
        contentView.addSubview(iconsHorizontalStackView)
        iconsHorizontalStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
    }
    
    private func setReadersCountLabel() {
        contentView.addSubview(readersCountLabel)
        readersCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconsHorizontalStackView.snp.centerY)
            make.left.equalTo(iconsHorizontalStackView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(24)
        }
        readersCountLabel.numberOfLines = 0
        readersCountLabel.textAlignment = .left
        readersCountLabel.font = UIFont.Basic.latoBold(size: 20)
        readersCountLabel.textColor = UIColor.white
    }
    
    private func setReadersTextLabel() {
        contentView.addSubview(readersTextLabel)
        readersTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconsHorizontalStackView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-16)
        }
        readersTextLabel.numberOfLines = 0
        readersTextLabel.textAlignment = .center
        readersTextLabel.font = UIFont.Basic.latoNormal(size: 16)
        readersTextLabel.textColor = UIColor.Main.textGray
        readersTextLabel.text = CommonString.peopleListedThisPodcast
    }
    
    private func setContinueButton() {
        contentView.addSubview(continueButton)
        continueButton.snp.makeConstraints { (make) in
            make.top.equalTo(readersTextLabel.snp.bottom).offset(60)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-50)
        }
        continueButton.buttonAction = {
            self.delegate?.didPressedContinue()
        }
    }
 
}


