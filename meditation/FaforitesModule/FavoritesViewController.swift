//
//  FavoritesViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import UIKit
import SkeletonView

class FavoritesViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .plain)
    
    var presenter: FavoritesPresenter?

    enum Section {
        case main
        case favorites
    }
    
    let sections: [Section] = [.main,
                               .favorites]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        view.isSkeletonable = true
        self.hideKeyboardWhenTappedAround()
        setTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        presenter?.dataModel.clear()
        presenter?.getData()
        tableView.reloadData()
    }
    
    deinit {
        print()
    }

    // MARK: - Private
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 88
        tableView.isSkeletonable = true
        tableView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
        tableView.register(FavoritesMainTableCell.self, forCellReuseIdentifier: "FavoritesMainTableCell")
        tableView.register(FavoriteTableCell.self, forCellReuseIdentifier: "FavoriteTableCell")
        
    }

}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .main:
                return 1
            case .favorites:
                return presenter?.dataModel.favoriteModel?.count ?? 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return favoritesMainTableCell(indexPath: indexPath)
            case .favorites:
                return favoriteTableCell(indexPath: indexPath)
        }
    }

    private func favoritesMainTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesMainTableCell", for: indexPath) as! FavoritesMainTableCell
        cell.delegate = self
        if let _ = presenter?.dataModel.favoriteModel {
            cell.setData(isEmpty: false)
        } else {
            cell.setSkeleton()
        }
        
        return cell
    }

    private func favoriteTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableCell", for: indexPath) as! FavoriteTableCell
        if let favorites = presenter?.dataModel.favoriteModel {
            let favorite = favorites[indexPath.row]
            let bufferedLink = presenter?.dataModel.bufferedVideos[indexPath.row]
            let title = favorite.lesson?.name ?? ""
            let subTitle = favorite.sections?.first?.name ?? ""
            let time = "\(favorite.sections?.first?.lessonsTime ?? 0) мин"
            cell.setData(bufferedLink: bufferedLink,
                         title: title,
                         subTitle: subTitle,
                         time: time)
        } else {
            cell.setSkeleton()
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favoriteModel = presenter?.dataModel.favoriteModel else { return }
        let lessonId = favoriteModel[indexPath.row].lessonId
        let lessons = favoriteModel.map { $0.lessonId ?? -1 }
        let lessonBufferedVideo = presenter?.dataModel.bufferedVideos
        let sectionName = favoriteModel[indexPath.row].sections?.first?.name ?? ""
        
        ModuleRouter.showPlayerModule(currentViewController: self,
                                      lessonId: lessonId ?? -1,
                                      lessons: lessons,
                                      lessonBufferedVideo: lessonBufferedVideo,
                                      sectionName: sectionName,
                                      idUnfinishedLessons: nil)
    }
}

// MARK: - FavoritesMainTableCellDelegate

extension FavoritesViewController : PlayerViewControllerDelegate {
    func didRemoveFromFavorites(index: Int) {
        presenter?.dataModel.favoriteModel?.remove(at: index)
    }
}

// MARK: - FavoritesMainTableCellDelegate

extension FavoritesViewController : FavoritesMainTableCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - FavoriteTableCellDelegate

extension FavoritesViewController : FavoriteTableCellDelegate {
    func playButtonPressed() {
        
    }
}


// MARK: - FavoritesProtocol

extension FavoritesViewController : FavoritesProtocol {
    func didLoadData() {
        tableView.reloadData()
    }
    
    func didLoadVideo(index: Int) {
//        tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
    }
}
