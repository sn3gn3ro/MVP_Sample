//
//  FavoritesViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    let tableView = UITableView()
    
    var presenter: FavoritesPresenter!

    enum Section {
        case main
        case favorites
    }
    
    let sections: [Section] = [.main,
                               .favorites]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
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
        tableView.separatorStyle = .none
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
                return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return favoritesMainTableCell(indexPath: indexPath)
            case .favorites:
                return favoriteTableCell(indexPath: indexPath, backImage: UIImage(named: "playedTest") ?? UIImage(), title: "Искусство диалога", subTitle: "Как найти подход?", time: "18 мин.")
        }
    }
    
    private func favoritesMainTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesMainTableCell", for: indexPath) as! FavoritesMainTableCell
        //TODO: - проверять количество favorites
        cell.setData(isEmpty: false)
        cell.delegate = self
        
        return cell
    }
    
    private func favoriteTableCell(indexPath: IndexPath, backImage: UIImage, title: String, subTitle: String, time: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableCell", for: indexPath) as! FavoriteTableCell
        cell.setData(backImage: backImage, title: title, subTitle: subTitle, time: time)
        
        return cell
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
    
}
