//
//  ProfileEditViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    let tableView = UITableView()
    
    var presenter: ProfileEditPresenter!

    enum Section {
        case main
    }
    
    let sections: [Section] = [.main]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
    
        tableView.register(ProfileEditMainTableCell.self, forCellReuseIdentifier: "ProfileEditMainTableCell")
    }

}

// MARK: - UITableViewDataSource

extension ProfileEditViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .main:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return profileEditMainTableCell(indexPath: indexPath)
        }
    }
    
    
    private func profileEditMainTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileEditMainTableCell", for: indexPath) as! ProfileEditMainTableCell
        cell.setData(name: "????????????????????", email: "alexandra@mail.ru", phone: "79088089389")
        cell.delegate = self
        
        return cell
    }
}

// MARK: - ProfileEditMainTableCellDelegate

extension ProfileEditViewController : ProfileEditMainTableCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didEnterName(name: String) {
        
    }
    
    func didEnterEmail(email: String) {
        
    }
    
    func didEnterPhone(phone: String) {
        
    }
    
    func didPressedSaveChanges() {
        
    }
    
    func didPressedDeleteAccount() {
        let alertView = CustomAlertView(title: CommonString.deletingAccount, subtitle: CommonString.deletingAccountSubtitile, button: CustomAlertView.Button(title: CommonString.delete, action: {
            //delete
        }))
        
        alertView.show(view: self.view)
    }
}


// MARK: - ProfileEditProtocol

extension ProfileEditViewController : ProfileEditProtocol {
    
}
