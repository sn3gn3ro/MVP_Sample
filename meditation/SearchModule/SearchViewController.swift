//
//  SearchViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 03.02.2022.
//

import UIKit

class SearchViewController: UIViewController {

    let tableView = UITableView()
    
    var presenter: SearchPresenter!

    enum Section: Equatable {
        case main
        case hashtags
        case header(text: String)
        case popular
        case themes
    }
    
    let sections: [Section] = [.main,
                               .hashtags,
                               .header(text: CommonString.popular),
                               .popular,
                               .header(text: CommonString.podcastTheme),
                               .themes]
    
    var isDataHide = false

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
            make.bottom.equalToSuperview().offset(-TabbarSettings.height)
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
    
        tableView.register(SearchMainTableCell.self, forCellReuseIdentifier: "SearchMainTableCell")
        tableView.register(SearchHashtagsTableCell.self, forCellReuseIdentifier: "SearchHashtagsTableCell")
        tableView.register(MainRecomendedHeaderTableCell.self, forCellReuseIdentifier: "MainRecomendedHeaderTableCell")
        
        tableView.register(MainRecomendedTableCell.self, forCellReuseIdentifier: "MainRecomendedTableCell")
        tableView.register(MainPodcastTableCell.self, forCellReuseIdentifier: "MainPodcastTableCell")
    }

}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .main:
                return 1
            case .hashtags:
                return 1
            case .header(text: let text):
                return 1
            case .popular:
                return 1
            case .themes:
                return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return searchMainTableCell(indexPath: indexPath)
            case .hashtags:
                return searchHashtagsTableCell(indexPath: indexPath)
            case .header(let text):
                return mainRecomendedHeaderTableCell(indexPath: indexPath, text: text)
            case .popular:
                return mainRecomendedTableCell(indexPath: indexPath)
            case .themes:
                return mainPodcastTableCell(indexPath: indexPath)
        }
    }
    
    private func searchMainTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMainTableCell", for: indexPath) as! SearchMainTableCell
        cell.setData()
        cell.delegate = self
        
        return cell
    }
    
    
    private func searchHashtagsTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHashtagsTableCell", for: indexPath) as! SearchHashtagsTableCell
        isDataHide ?  cell.hideCollectionView()  : cell.showCollectionView()
        
        
        return cell
    }
    
    private func mainRecomendedHeaderTableCell(indexPath: IndexPath, text: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRecomendedHeaderTableCell", for: indexPath) as! MainRecomendedHeaderTableCell
        cell.setData(text: text)
        
        return cell
    }
    
    private func mainRecomendedTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRecomendedTableCell", for: indexPath) as! MainRecomendedTableCell
        cell.setData()
        
        return cell
    }
    
    private func mainPodcastTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPodcastTableCell", for: indexPath) as! MainPodcastTableCell
        cell.setData(backImage: UIImage(named: "podcastTest") ?? UIImage(), title: "Отношения", subTitle: "10 тем, 24 аудиоурока")
        
        return cell
    }
    
    
    
    
}

// MARK: - SearchMainTableCellDelegate

extension SearchViewController : SearchMainTableCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didChangeSearchText(text: String) {
        isDataHide = text != ""
        guard let index = sections.firstIndex(where: {$0 == .hashtags}) else { return }
        tableView.reloadSections(IndexSet(arrayLiteral: index), with: .automatic)
    }
}



// MARK: - FavoritesProtocol

extension SearchViewController : SearchProtocol {
    
}
