//
//  NotificationSettingsViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import UIKit

class NotificationSettingsViewController: UIViewController {

    let tableView = UITableView()
    
    var presenter: NotificationSettingsPresenter!

    enum Section {
        case main
        case switches
    }
    
    let sections: [Section] = [.main,
                               .switches]
    
    struct Settings {
        let type: NotificationSettingsSwitchTableCell.NotificationType
        var isOn: Bool
    }
    
    var settings: [Settings] = [Settings(type: .common, isOn: false),
                                Settings(type: .aboutNewLessons, isOn: false),
                                Settings(type: .aboutNewOffers, isOn: false)]

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
    
        tableView.register(NotificationSettingsMainCell.self, forCellReuseIdentifier: "NotificationSettingsMainCell")
        tableView.register(NotificationSettingsSwitchTableCell.self, forCellReuseIdentifier: "NotificationSettingsSwitchTableCell")
    }

}

// MARK: - UITableViewDataSource

extension NotificationSettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .main:
                return 1
            case .switches:
                return settings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return notificationSettingsMainCell(indexPath: indexPath)
            case .switches:
                return notificationSettingsSwitchTableCell(indexPath: indexPath, type: settings[indexPath.row].type, isOn: settings[indexPath.row].isOn)
        }
    }
    
    private func notificationSettingsMainCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationSettingsMainCell", for: indexPath) as! NotificationSettingsMainCell
        cell.delegate = self
        
        return cell
    }
    
    private func notificationSettingsSwitchTableCell(indexPath: IndexPath, type: NotificationSettingsSwitchTableCell.NotificationType, isOn: Bool) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationSettingsSwitchTableCell", for: indexPath) as! NotificationSettingsSwitchTableCell
        cell.setData(type: type, isOn: isOn)
        cell.delegate = self

        return cell
    }
}

// MARK: - FavoritesMainTableCellDelegate

extension NotificationSettingsViewController : NotificationSettingsMainCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - NotificationSettingsSwitchTableCellDelegate

extension NotificationSettingsViewController : NotificationSettingsSwitchTableCellDelegate {
    func didChangeSwitch(type: NotificationSettingsSwitchTableCell.NotificationType, isOn: Bool) {
        guard let index = settings.firstIndex(where: {$0.type == type}) else { return }
        settings[index].isOn = isOn
    }
}


// MARK: - NotificationSettingsProtocol

extension NotificationSettingsViewController : NotificationSettingsProtocol {
    
}
