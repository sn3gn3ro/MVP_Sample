//
//  MainViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    let tableView = UITableView()
 
    var presenter: MainPresenter!
    
    enum Section {
        case picture
        case search
        case played
        case recomendedHeader
        case recomended
        case podcastsHeader
        case podcasts
    }
    
    var sections: [Section] = [.picture,
                               .search,
                               .played,
                               .recomendedHeader,
                               .recomended,
                               .podcastsHeader,
                               .podcasts]
    
    struct TestData {
        let image: UIImage?
        let title: String
        let themeCount: Int
        let lessonsCount: Int
    }
    
    let testPodcastArray: [TestData] = [TestData(image: UIImage(named: "podcastTest"), title: "Отношения", themeCount: 10, lessonsCount: 24),
                                        TestData(image: UIImage(named: "podcastTest2"), title: "Социальные проблемы", themeCount: 8, lessonsCount: 5),
                                        TestData(image: UIImage(named: "podcastTest3"), title: "Эмоции", themeCount: 5, lessonsCount: 12)]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: Notification.Name("showTabbar"), object: nil, userInfo: nil)
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
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
    
        tableView.register(MainPictureTableCell.self, forCellReuseIdentifier: "MainPictureTableCell")
        tableView.register(MainSearchTableCell.self, forCellReuseIdentifier: "MainSearchTableCell")
        tableView.register(MainPlayedTableCell.self, forCellReuseIdentifier: "MainPlayedTableCell")
        tableView.register(MainRecomendedHeaderTableCell.self, forCellReuseIdentifier: "MainRecomendedHeaderTableCell")
        tableView.register(MainRecomendedTableCell.self, forCellReuseIdentifier: "MainRecomendedTableCell")
        tableView.register(MainPodcastsHeaderTableCell.self, forCellReuseIdentifier: "MainPodcastsHeaderTableCell")
        tableView.register(MainPodcastTableCell.self, forCellReuseIdentifier: "MainPodcastTableCell")
//        tableView.register(MainSearchHashtagsTableCell.self, forCellReuseIdentifier: "MainSearchHashtagsTableCell")
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .picture:
                return 1
            case .search:
                return 1
            case .played:
                return 1
            case .recomendedHeader:
                return 1
            case .recomended:
                return 1
            case .podcastsHeader:
                return 1
            case .podcasts:
                return testPodcastArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .picture:
                return PictureTableCell(indexPath: indexPath, image: UIImage(named: "backTest") ?? UIImage())
            case .search:
                return SearchTableCell(indexPath: indexPath, backgroundColor: UIColor.Main.tabbarBackground, name: "Александра")
            case .played:
                return PlayedTableCell(indexPath: indexPath, backImage: UIImage(named: "playedTest") ?? UIImage(), title: "Искусство диалога", subTitle: "Как найти подход?", time: "18 мин.")
            case .recomendedHeader:
                return RecomendedHeaderTableCell(indexPath: indexPath)
            case .recomended:
                return RecomendedTableCell(indexPath: indexPath)
            case .podcastsHeader:
                return PodcastsHeaderTableCell(indexPath: indexPath)
            case .podcasts:
                let podcast = testPodcastArray[indexPath.row]
                return podcastTableCell(indexPath: indexPath, backImage: podcast.image ?? UIImage(), title: podcast.title, subTitle: "\(podcast.themeCount) тем, \(podcast.lessonsCount) аудиоурока")
        }
    }
    
    
    private func PictureTableCell(indexPath: IndexPath, image: UIImage) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPictureTableCell", for: indexPath) as! MainPictureTableCell
        cell.setImage(image: image)
        
        return cell
    }
    
    private func SearchTableCell(indexPath: IndexPath, backgroundColor: UIColor, name: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainSearchTableCell", for: indexPath) as! MainSearchTableCell
        cell.setData(backgroundColor: backgroundColor, name: name)
        cell.delegate = self
        
        return cell
    }
    
    private func PlayedTableCell(indexPath: IndexPath, backImage: UIImage, title: String, subTitle: String, time: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlayedTableCell", for: indexPath) as! MainPlayedTableCell
        cell.setData(backImage: backImage, title: title, subTitle: subTitle, time: time)
        cell.delegate = self
        
        return cell
    }
    
    private func RecomendedHeaderTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRecomendedHeaderTableCell", for: indexPath) as! MainRecomendedHeaderTableCell
        
        return cell
    }
    
    private func RecomendedTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRecomendedTableCell", for: indexPath) as! MainRecomendedTableCell
        cell.setData()
        cell.delegate = self
        
        return cell
    }
    
    private func PodcastsHeaderTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPodcastsHeaderTableCell", for: indexPath) as! MainPodcastsHeaderTableCell
        cell.delegate = self
        
        return cell
    }
    
    private func podcastTableCell(indexPath: IndexPath,backImage: UIImage, title: String, subTitle: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPodcastTableCell", for: indexPath) as! MainPodcastTableCell
        cell.setData(backImage: backImage, title: title, subTitle: subTitle)
        
        return cell
    }
    

    
}

// MARK: - MainSearchTableCellDelegate

extension MainViewController : MainSearchTableCellDelegate {
    func searchButtonPressed() {
        ModuleRouter.showSearchModule(currentViewController: self)
//        sections = [.picture,
//                    .search,
//                    .searchHashtags,
//                    .played,
//                    .recomendedHeader,
//                    .recomended,
//                    .podcastsHeader,
//                    .podcasts]
//        tableView.reloadData()
    }
}

// MARK: - MainPlayedTableCellDelegate

extension MainViewController : MainPlayedTableCellDelegate {
    func playButtonPressed() {
        
    }
}

// MARK: - MainRecomendedTableCellDelegate

extension MainViewController : MainRecomendedTableCellDelegate {
    func didSelectPodcast(index: Int) {
//        ModuleRouter.showCategoryModule(currentViewController: self)
        NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
        ModuleRouter.showPlayerModule(currentViewController: self)
    }
}

// MARK: - MainPodcastsHeaderTableCellDelegate

extension MainViewController : MainPodcastsHeaderTableCellDelegate {
    func moreButtonPressed() {
        
    }
}

// MARK: - UITableViewDelegate

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
            case .podcasts:
                ModuleRouter.showCategoryModule(currentViewController: self)
            default:
                break
        }
    }
}


// MARK: - MainProtocol

extension MainViewController : MainProtocol {
    
}
