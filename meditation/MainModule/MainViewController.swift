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
    
    let sections: [Section] = [.picture,
                               .search,
                               .played,
                               .recomendedHeader,
                               .recomended,
                               .podcastsHeader,
                               .podcasts]

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
    
        tableView.register(MainPictureTableCell.self, forCellReuseIdentifier: "MainPictureTableCell")
        tableView.register(MainSearchTableCell.self, forCellReuseIdentifier: "MainSearchTableCell")
        tableView.register(MainPlayedTableCell.self, forCellReuseIdentifier: "MainPlayedTableCell")
        tableView.register(MainRecomendedHeaderTableCell.self, forCellReuseIdentifier: "MainRecomendedHeaderTableCell")
        tableView.register(MainRecomendedTableCell.self, forCellReuseIdentifier: "MainRecomendedTableCell")
        tableView.register(MainPodcastsHeaderTableCell.self, forCellReuseIdentifier: "MainPodcastsHeaderTableCell")
        tableView.register(MainPodcastTableCell.self, forCellReuseIdentifier: "MainPodcastTableCell")
        
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
                return 7
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
                return PodcastTableCell(indexPath: indexPath, backImage: UIImage(named: "podcastTest") ?? UIImage(), title: "Отношения", subTitle: "10 тем, 24 аудиоурока")
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
        
        return cell
    }
    
    private func PlayedTableCell(indexPath: IndexPath, backImage: UIImage, title: String, subTitle: String, time: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlayedTableCell", for: indexPath) as! MainPlayedTableCell
        cell.setData(backImage: backImage, title: title, subTitle: subTitle, time: time)
        
        return cell
    }
    
    private func RecomendedHeaderTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRecomendedHeaderTableCell", for: indexPath) as! MainRecomendedHeaderTableCell
        
        return cell
    }
    
    private func RecomendedTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRecomendedTableCell", for: indexPath) as! MainRecomendedTableCell
        cell.setData()
        
        return cell
    }
    
    private func PodcastsHeaderTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPodcastsHeaderTableCell", for: indexPath) as! MainPodcastsHeaderTableCell
        
        return cell
    }
    
    private func PodcastTableCell(indexPath: IndexPath,backImage: UIImage, title: String, subTitle: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPodcastTableCell", for: indexPath) as! MainPodcastTableCell
        cell.setData(backImage: backImage, title: title, subTitle: subTitle)
        
        return cell
    }
    
    
}

// MARK: - SignUpMainTableCellDelegate

//extension MainViewController : SignUpMainTableCellDelegate {
    
//    func didPressedCreateAccount() {
//        ModuleRouter.showSignUpEmailModule(currentViewController: self, email: presenter.dataModel.email ?? "", password:  presenter.dataModel.password ?? "")
//    }
//
//    func didPressedGoogle() {
//
//    }
//
//    func didPressedApple() {
//
//    }
//
//    func didPressedPhone() {
////        ModuleRouter.showSignUpPhoneModule(currentViewController: self)
//        ModuleRouter.showLogInPhoneModule(currentViewController: self, phone: nil)
//    }
//
//    func didPressedEnter() {
//        ModuleRouter.showLogInEmailModule(currentViewController: self, email: presenter.dataModel.email)
//    }
//
//    func didEnterEmail(email: String) {
//        presenter.dataModel.email = email
//    }
//
//    func didEnterPassword(password: String) {
//        presenter.dataModel.password = password
//    }
//}

// MARK: - MainProtocol

extension MainViewController : MainProtocol {
    
}
