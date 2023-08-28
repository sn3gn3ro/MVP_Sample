//
//  CategoryCollectionElementsTableCell.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.01.2022.
//

import UIKit

protocol CategoryCollectionElementsTableCellDelegate: AnyObject {
    func didSelectElement(indexPath: IndexPath)
}

class CategoryCollectionElementsTableCell: UITableViewCell {
 
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    weak var delegate: CategoryCollectionElementsTableCellDelegate?
    
    var lessons: [SectionModel.Lessons] = []
    var bufferedLessonVideos = [Int: URL]()
    
    enum Const {
        static let offset: CGFloat = 16
        static let elementWidth = (UIScreen.main.bounds.width - (offset * 3)) / 2
        static let elementHeight = elementWidth * 0.9
    }
    
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
    
    func setData(lessons: [SectionModel.Lessons]) {
        self.lessons = lessons
        collectionView.snp.updateConstraints { (make) in
            let columnCount =  lessons.count > 1 ?  (CGFloat(lessons.count)/2).rounded() : 1
            let topOffsetHeight = CGFloat(columnCount) * Const.offset
            make.height.equalTo(CGFloat(columnCount) * Const.elementHeight + topOffsetHeight)//(163))
        }
        collectionView.reloadData()
    }
    
    func updateData(index: Int, url: URL) {
        bufferedLessonVideos[index] = url
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
    
    //MARK: - Private

    private func configureCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(31)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(146)
        }
        collectionView.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Const.offset
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Const.offset, bottom: 0, right: Const.offset)
        collectionView.register(ElementInCategoryCollectionCell.self, forCellWithReuseIdentifier: "ElementInCategoryCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


//MARK: - UICollectionViewDelegate

extension CategoryCollectionElementsTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectElement(indexPath: indexPath)
    }
}

//MARK: - UICollectionViewDataSource

extension CategoryCollectionElementsTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementInCategoryCollectionCell", for: indexPath) as! ElementInCategoryCollectionCell
        let lesson = lessons[indexPath.row]
        let url = lesson.getCurrentDayLink()
        let bufferedLink = bufferedLessonVideos[indexPath.row]
        let isLissend = lesson.listened ?? false
        cell.setData(videoUrl: url,
                     bufferedLink: bufferedLink,
                     lessonName: lesson.name ?? "",
                     isLissend: isLissend)
        
        return cell
    }
}



//MARK: - UICollectionViewDelegateFlowLayout

extension CategoryCollectionElementsTableCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Const.elementWidth, height: Const.elementHeight)//CGSize(width: 163, height: 146)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
