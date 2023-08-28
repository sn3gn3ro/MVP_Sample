//
//  MainViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    var presenter: MainPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
        
        presenter.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getUserInfo()
        presenter.getListed()
        NotificationCenter.default.post(name: Notification.Name("showTabbar"), object: nil, userInfo: nil)
    }
    
    // MARK: - Private
    
    @objc private func refresh() {
        presenter.clearData()
        presenter.getData()
        tableView.reloadData()
    }
    
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
        
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
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
        return presenter.dataModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = presenter.dataModel.sections[section]
        switch section {
        case .podcasts:
            return presenter.dataModel.sectionListModel?.data?.count ?? 0
        case .played:
            if presenter.dataModel.userListenedListModel?.lessonId != nil {
                return 1
            } else {
                return 0
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = presenter.dataModel.sections[indexPath.section]
        switch section {
            case .picture:
                return pictureTableCell(indexPath: indexPath)
            case .search:
                return searchTableCell(indexPath: indexPath)
            case .played:
                return playedTableCell(indexPath: indexPath)
            case .recomendedHeader:
                return recomendedHeaderTableCell(indexPath: indexPath)
            case .recomended:
                return recomendedTableCell(indexPath: indexPath)
            case .podcastsHeader:
                return podcastsHeaderTableCell(indexPath: indexPath)
            case .podcasts:
                return podcastTableCell(indexPath: indexPath)
        }
    }
    
    private func pictureTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPictureTableCell", for: indexPath) as! MainPictureTableCell
//        cell.delegate = self
        if let settings = presenter.dataModel.settings {
            cell.setData(videoUrl: settings.getCurrentDayLink(), bufferedLink: presenter.dataModel.bufferedSettingsVideo)
        }
        
        return cell
    }
    
    private func searchTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainSearchTableCell", for: indexPath) as! MainSearchTableCell
        cell.delegate = self
        if let _ = presenter.dataModel.userInfoModel {
            cell.setData(backgroundColor: UIColor.Main.tabbarBackground,
                         name: presenter.dataModel.userInfoModel?.name ?? "")
        } else {
            cell.setSkeleton()
        }
        
        return cell
    }
    
    private func playedTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlayedTableCell", for: indexPath) as! MainPlayedTableCell
        cell.delegate = self
        if let section = presenter.dataModel.userListenedListModel {
            let videoUrl = section.lesson?.getCurrentDayLink() ?? ""
            let bufferedLink = presenter.dataModel.bufferedListed
            let title = section.lesson?.name ?? ""
            let subTitle = section.sections?.first?.name ?? ""
            let time = "\(section.sections?.first?.lessonsTime ?? 0) мин"
            cell.setData(videoUrl: videoUrl,
                         bufferedLink: bufferedLink,
                         title: title,
                         subTitle: subTitle,
                         time: time)
        } else {
            cell.setSkeleton()
        }
        
        return cell
    }
    
    private func recomendedHeaderTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRecomendedHeaderTableCell", for: indexPath) as! MainRecomendedHeaderTableCell
        if let _ = presenter.dataModel.sectionListModel {
            cell.setData(text: CommonString.recomendForYou)
        } else {
            cell.setSkeleton()
        }
        return cell
    }
    
    private func recomendedTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRecomendedTableCell", for: indexPath) as! MainRecomendedTableCell
        cell.delegate = self
        if let section = presenter.dataModel.sectionListModel?.data?[indexPath.row] {
//            let videoLink = section.paths?.getCurrentDayLink() ?? ""
            let bufferedLinks = presenter.dataModel.bufferedRecomended
            cell.setData(urls: [],bufferedLinks: bufferedLinks)
        } else {
            cell.setSkeleton()
        }
        
        return cell
    }
    
    private func podcastsHeaderTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPodcastsHeaderTableCell", for: indexPath) as! MainPodcastsHeaderTableCell
        cell.delegate = self
        if let _ = presenter.dataModel.sectionListModel {
            cell.setData()
        } else {
            cell.setSkeleton()
        }
        
        return cell
    }
    
    private func podcastTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPodcastTableCell", for: indexPath) as! MainPodcastTableCell
        if let section = presenter.dataModel.sectionListModel?.data?[indexPath.row] {
            let lessonsCount = section.sectionLessons?.count ?? 0
            let videoUrl = section.paths?.getCurrentDayLink() ?? ""
            let bufferedLink = presenter.dataModel.bufferedSection[indexPath.row]
            cell.setData(videoUrl: videoUrl,
                         bufferedLink: bufferedLink,
                         title: section.name ?? "",
                         subTitle: "\(0) тем, \(lessonsCount) аудиоурока")
        } else {
            cell.setSkeleton()
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch presenter.dataModel.sections[indexPath.section] {
        case .played:
            guard let lesson = presenter.dataModel.userListenedListModel else { return }
            ModuleRouter.showPlayerModule(currentViewController: self,
                                          lessonId: lesson.lessonId ?? 0,
                                          lessons: [],
                                          lessonBufferedVideo: [:],
                                          sectionName: presenter.dataModel.userListenedListModel?.sections?.first?.name,
                                          idUnfinishedLessons: nil)
        case .podcasts:
            guard let section = presenter.dataModel.sectionListModel?.data?[indexPath.row] else { return }
            if let buffered = presenter.dataModel.bufferedSection[indexPath.row] {
                ModuleRouter.showCategoryModule(currentViewController: self,
                                                dataModel: section,
                                                sectonVideoURL: CategoryDataModel.SectonVideoURL(link: buffered.absoluteString,
                                                                                                 isBuffered: true))
            } else {
                ModuleRouter.showCategoryModule(currentViewController: self,
                                                dataModel: section,
                                                sectonVideoURL: CategoryDataModel.SectonVideoURL(link: section.paths?.getCurrentDayLink() ?? "",
                                                                                                 isBuffered: false))
            }
        default:
            break
        }
    }
}

// MARK: - MainProtocol

extension MainViewController : MainProtocol {

    func didLoadSettings() {
        reloadSection(section: .picture)
    }
    
    func didLoadUserInfo() {
        refreshControl.endRefreshing()
        reloadSection(section: .search)
    }
    
    func didLoadListed() {
        reloadSection(section: .played)
    }
    
    func didLoadSectionList() {
       
        reloadSection(section: .podcasts)
        reloadSection(section: .podcastsHeader)
    }
    
    //Videos

    func didLoadSettingsVideo() {
        reloadSection(section: .picture)
    }
    
    func didLoadListedVideo() {
        reloadSection(section: .played)
    }
    
    func didLoadRecomendedVideo(index: Int) {
        reloadSection(section: .recomendedHeader)
        reloadSection(section: .recomended)
    }
    
    func didLoadSectionsVideo(index: Int) {
        reloadRow(section: .podcasts, row: index)
    }
    
    func reloadSection(section: MainDataModel.Section) {
        guard let index = presenter.dataModel.sections.firstIndex(of: section) else { return }
        tableView.reloadSections(IndexSet(arrayLiteral: index), with: .none)
    }
    
    func reloadRow(section: MainDataModel.Section, row: Int) {
        guard let section = presenter.dataModel.sections.firstIndex(of: section) else { return }
        tableView.reloadRows(at: [IndexPath(item: row, section: section)], with: .none)
    }
}
