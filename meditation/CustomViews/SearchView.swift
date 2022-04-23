//
//  SearchView.swift
//  meditation
//
//  Created by Ilya Medvedev on 03.02.2022.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didChangeSearchText(text: String)
}

class SearchView: UIView {
    
    let searchTextField = UITextField()
    let iconImageView = UIImageView()
    
//    let button = UIButton()
    
//    var buttonAction:(()->())?
    weak var delegate: SearchViewDelegate?
    
    init(placeholderText: String) {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
        
//        searchTextField.placeholder = placeholderText
//        searchTextField.backgroundColor = UIColor.Main.darkWhite
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        setSelf()
        setSearchTextField()
        setIconImageView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Actions
    
    @objc func textEdit() {
        delegate?.didChangeSearchText(text: searchTextField.text ?? "")
    }

    // MARK: - Private
    
    private func setSelf() {
        layer.cornerRadius = 12
        backgroundColor = UIColor.white.withAlphaComponent(0.3)
    }
    
    private func setSearchTextField() {
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-46)
            make.centerY.equalToSuperview()
        }
       
        searchTextField.textAlignment = .left
        searchTextField.font = UIFont.Basic.latoNormal(size: 14)
        searchTextField.textColor = .white
        
        searchTextField.addTarget(self, action: #selector(textEdit), for: .editingChanged)
//        searchTextField.addTarget(self, action:  #selector(textEdit), for: .editingDidBegin)
    }
    
    private func setIconImageView() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(28)
        }
        iconImageView.image = UIImage(named: "searchWhiteRoundButton")
    }
}


