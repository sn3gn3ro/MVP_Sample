//
//  ProfileViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let tableView = UITableView()
    
    var presenter: ProfilePresenter!

    enum Section {
        case main
        case settings(types:[ProfileSettingTableCell.Setting])
        case exit
    }
    
    let sections: [Section] = [.main,
                               .settings(types: [ProfileSettingTableCell.Setting.favoritesLessons,
                                                 ProfileSettingTableCell.Setting.subscription,
                                                 ProfileSettingTableCell.Setting.notifications,
                                                 ProfileSettingTableCell.Setting.review]),
                               .exit]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
        
//        presenter.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.dataModel.isDataLoad = false
        tableView.reloadData()
        presenter.getData()
        
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
    
        tableView.register(ProfileMainTableCell.self, forCellReuseIdentifier: "ProfileMainTableCell")
        tableView.register(ProfileSettingTableCell.self, forCellReuseIdentifier: "ProfileSettingTableCell")
        tableView.register(ProfileExitTableCell.self, forCellReuseIdentifier: "ProfileExitTableCell")
    }

}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
            case .settings(let types):
                settingsAction(type: types[indexPath.row])
            case .exit:
           break
            default:
                break
        }
    }
    
    func settingsAction(type: ProfileSettingTableCell.Setting) {
        switch type {
            case .favoritesLessons:
                NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
                ModuleRouter.showFavoritesModule(currentViewController: self)
            case .subscription:
                   NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
                   ModuleRouter.showSubscriptionModule(currentViewController: self)
            case .notifications:
                NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
                ModuleRouter.showNotificationsSettingsModule(currentViewController: self)
            case .review:
                print("")
        }
       
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .main:
                return 1
            case .settings(let types):
                return types.count
            case .exit:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return profileMainTableCell(indexPath: indexPath, image: UIImage(named: "backTest") ?? UIImage())
            case .settings(let types):
                let type = types[indexPath.row]
                return profileSettingTableCell(indexPath: indexPath, type: type)
            case .exit:
                return profileExitTableCell(indexPath: indexPath)
        }
    }
    
    
    private func profileMainTableCell(indexPath: IndexPath, image: UIImage) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMainTableCell", for: indexPath) as! ProfileMainTableCell
        
        presenter.dataModel.isDataLoad ? cell.setData(backImage: UIImage(named: "backNightTest") ?? UIImage(),
                                                      profileImage: UIImage(named: "userPhotoTest") ?? UIImage(),
                                                      email: "alexandra@mail.ru",
                                                      name: "Александра") : cell.setSkeleton()
        
        cell.delegate = self
        
        return cell
    }
    
    private func profileSettingTableCell(indexPath: IndexPath, type: ProfileSettingTableCell.Setting) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSettingTableCell", for: indexPath) as! ProfileSettingTableCell
        
        presenter.dataModel.isDataLoad ? cell.setData(type: type) :  cell.setSkeleton()
        
        return cell
    }
    
    private func profileExitTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileExitTableCell", for: indexPath) as! ProfileExitTableCell
        cell.delegate = self
        presenter.dataModel.isDataLoad ? cell.setData() :  cell.setSkeleton()
        
        return cell
    }  
}

// MARK: - ProfileMainTableCellDelegate

extension ProfileViewController : ProfileMainTableCellDelegate {
    func favoritesPressed() {
        
    }
    
    func profileImagePressed() {
        
    }
    
    func editPressed() {
        NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
        ModuleRouter.showProfileEditModule(currentViewController: self)
    }
}

// MARK: - ProfileExitTableCellDelegate

extension ProfileViewController: ProfileExitTableCellDelegate {
    func exitButtonPressed() {
        guard let window = UIApplication.shared.windows.first else { return }
        UserDefaultsManager.clearToken()
        ModuleRouter.setRootSignUpModule(window: window)
    }
}


// MARK: - ProfileProtocol

extension ProfileViewController : ProfileProtocol {
    func dataLoad() {
        tableView.reloadData()
    }
    
    
}
