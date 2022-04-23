//
//  SearchHashtagsTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 02.02.2022.
//

import UIKit

class SearchHashtagsTableCell: UITableViewCell {
    
    private let emptyLabel = UILabel()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let hashtags: [String] = ["#Социальные проблемы",
                             "#Эмоции",
                             "#Мотивация",
                             "#Эмоциональный интеллект",
                             "#Тревога",
                             "#Страхи",
                             "#Отношения",
                             "#Паническая атака"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        setEmptyLabel()
        setCollectionView()
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
       
    }
    
    func hideCollectionView() {
        emptyLabel.isHidden = false
        collectionView.isHidden = true
    }
    
    func showCollectionView() {
        emptyLabel.isHidden = true
        collectionView.isHidden = false
    }
    
    //MARK: - Private
    
    private func setEmptyLabel() {
        contentView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
//            make.bottom.equalToSuperview()
        }
        emptyLabel.textAlignment = .left
        emptyLabel.numberOfLines = 0
        emptyLabel.font = UIFont.Basic.latoNormal(size: 16)
        emptyLabel.textColor = UIColor.white
        emptyLabel.text = CommonString.searchEmptyText
//        emptyLabel.isHidden = true
    }
    
    private func setCollectionView() {
        let layout = AlignedCollectionViewFlowLayout()//UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.horizontalAlignment = .left
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 6
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(126)
        }
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(HashtagCollectionCell.self, forCellWithReuseIdentifier: "HashtagCollectionCell")
    }
}

//MARK: - UICollectionViewDelegate

extension SearchHashtagsTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.didSelectSubscriptionTwoOption()
    }
}

//MARK: - UICollectionViewDataSource

extension SearchHashtagsTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashtags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "HashtagCollectionCell", for: indexPath) as! HashtagCollectionCell
        cell.setData(text: hashtags[indexPath.row])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SearchHashtagsTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = hashtags[indexPath.row]
        let textWidth = text.width(withConstrainedHeight: 14, font: UIFont.Basic.latoBold(size: 12))
        
        let height: CGFloat = 34
        let widht: CGFloat = textWidth + 20
        
        return CGSize(width: widht, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        //расстояние между верхним и нижним элементом
//        return 12
//    }
    
}
