//
//  MainRecomendedTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 19.01.2022.
//

import UIKit
import SkeletonView

protocol MainRecomendedTableCellDelegate: AnyObject {
    func didSelectPodcast(index: Int)
//    func didLoadVideo(cell: UITableViewCell, bufferedLinks: [Int:URL])
}

class MainRecomendedTableCell: UITableViewCell {
    
    enum Const {
        static let itemHeight = 181
        static let itemWidth = 160
    }
    
    struct TestData {
        let image: UIImage?
        let title: String
        let subTitle: String
        let lessonsCount: Int
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let testDataArray: [TestData] = [TestData(image: UIImage(named: "recomendedTest"), title: "Как найти подход?", subTitle: "Социальные проблемы", lessonsCount: 5),
                                     TestData(image: UIImage(named: "recomendedTest2"), title: "Что такое тревога?", subTitle: "Тревога", lessonsCount: 12),
                                     TestData(image: UIImage(named: "recomendedTest3"), title: "Цели", subTitle: "Мотивация", lessonsCount: 5)]
    var isSkeleton = false
    
    var urls = [String]()
    var bufferedLinks = [Int:URL]()
    
    weak var delegate: MainRecomendedTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.backgroundColor = .clear
        self.isSkeletonable = true
        
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
    
    func setData(urls: [String], bufferedLinks: [Int:URL]?) {
        hideSkeleton()
        self.urls = urls
        self.bufferedLinks = bufferedLinks ?? [:]
        isSkeleton = false
        collectionView.reloadData()
    }
    
    func setSkeleton() {
        setSkeletonableStyle()
        isSkeleton = true
        collectionView.reloadData()
    }
    
    //MARK: - Private
    
    private func configureCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(Const.itemHeight)
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
        collectionView.isSkeletonable = true
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
        return bufferedLinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainRecomendedCollectionCell", for: indexPath) as! MainRecomendedCollectionCell
        let bufferedLink = bufferedLinks[indexPath.row]
        isSkeleton ?  cell.setSkeleton() : cell.setData(videoUrl: "",
                                                        bufferedLink: bufferedLink,
                                                        lessonCount: 3,
                                                        title: "Как найти подход?",
                                                        subtitle: "Социальные проблемы")
        
        return cell
    }

}

//MARK: - SkeletonCollectionViewDataSource

extension MainRecomendedTableCell: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "MainRecomendedCollectionCell"
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainRecomendedTableCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Const.itemWidth, height: Const.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
