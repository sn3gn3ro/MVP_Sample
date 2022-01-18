//
//  MainRecomendedTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 19.01.2022.
//

import UIKit

protocol MainRecomendedTableCellDelegate: AnyObject {
    func didSelectPodcast(index: Int)
}

class MainRecomendedTableCell: UITableViewCell {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    weak var delegate: MainRecomendedTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        
        
        configureCollectionView()
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
    
    //MARK: - Private
    
    private func configureCollectionView() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(171)
        }
        
        collectionView.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(MainRecomendedCollectionCell.self, forCellWithReuseIdentifier: "MainRecomendedCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


//MARK: - UICollectionViewDelegate

extension MainRecomendedTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectPodcast(index: indexPath.row)
    }
}

//MARK: - UICollectionViewDataSource

extension MainRecomendedTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainRecomendedCollectionCell", for: indexPath) as! MainRecomendedCollectionCell
        cell.setData(image: UIImage(named: "recomendedTest") ?? UIImage(), lessonCount: 5, title: "Как найти подход?", subtitle: "Социальные проблемы")
        
        return cell
    }

}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainRecomendedTableCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 160, height: 171)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
