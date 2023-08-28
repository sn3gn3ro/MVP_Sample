//
//  CongratulationViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 28.01.2022.
//

import UIKit

class CongratulationViewController: UIViewController {

    let tableView = UITableView()
 
    var presenter: CongratulationPresenter!
    
    enum Section {
        case main
        case challenge
        case bottom
        
    }
    
    let sections: [Section] = [.main,
                               .challenge,
                               .bottom]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.post(name: Notification.Name("showTabbar"), object: nil, userInfo: nil)
    }
    
    // MARK: - Private
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()//.offset(-TabbarSettings.height)
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
    
        tableView.register(CongratulationMainTableCell.self, forCellReuseIdentifier: "CongratulationMainTableCell")
        tableView.register(FavoriteTableCell.self, forCellReuseIdentifier: "FavoriteTableCell")
        tableView.register(CongratulationBottomTableCell.self, forCellReuseIdentifier: "CongratulationBottomTableCell")
        
    }
}

// MARK: - UITableViewDataSource

extension CongratulationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .main:
                return 1
            case .challenge:
                return 1
            case .bottom:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return congratulationMainTableCell(indexPath: indexPath)
            case .challenge:
                return favoriteTableCell(indexPath: indexPath, backImage: UIImage(named: "playedTest") ?? UIImage(), title: "Искусство диалога", subTitle: "Как найти подход?", time: "18 мин.")
            case .bottom:
                return congratulationBottomTableCell(indexPath: indexPath)
        }
    }
    
    
    private func congratulationMainTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CongratulationMainTableCell", for: indexPath) as! CongratulationMainTableCell
        
        return cell
    }
    
    private func favoriteTableCell(indexPath: IndexPath, backImage: UIImage, title: String, subTitle: String, time: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableCell", for: indexPath) as! FavoriteTableCell
//        cell.setData(backImage: backImage, title: title, subTitle: subTitle, time: time)
        
        return cell
    }
    
    private func congratulationBottomTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CongratulationBottomTableCell", for: indexPath) as! CongratulationBottomTableCell
        cell.setData()
        cell.delegate = self
        
        return cell
    }

}

// MARK: - CongratulationBottomTableCellDelegate

extension CongratulationViewController : CongratulationBottomTableCellDelegate {
    func didPressedContinue() {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
//
//// MARK: - MainPlayedTableCellDelegate
//
//extension MainViewController : MainPlayedTableCellDelegate {
//    func playButtonPressed() {
//
//    }
//}
//
//// MARK: - MainRecomendedTableCellDelegate
//
//extension CongratulationViewController : MainRecomendedTableCellDelegate {
//    func didSelectPodcast(index: Int) {
////        ModuleRouter.showCategoryModule(currentViewController: self)
//        NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
//        ModuleRouter.showPlayerModule(currentViewController: self)
//    }
//}
//
//// MARK: - MainPodcastsHeaderTableCellDelegate
//
//extension CongratulationViewController : MainPodcastsHeaderTableCellDelegate {
//    func moreButtonPressed() {
//
//    }
//}

// MARK: - UITableViewDelegate

extension CongratulationViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch sections[indexPath.section] {
//            case .podcasts:
//                ModuleRouter.showCategoryModule(currentViewController: self)
//            default:
//                break
//        }
//    }
}


// MARK: - CongratulationProtocol

extension CongratulationViewController : CongratulationProtocol {
    
}
