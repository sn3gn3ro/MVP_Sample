//
//  SignUpViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    let tableView = UITableView()
    
 
    var presenter: SignUpPresenter!
    
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
    
    // MARK: - Private
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()//.offset(UIApplication.shared.statusBarFrame.height)
            make.bottom.left.right.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
        tableView.register(SignUpMainTableCell.self, forCellReuseIdentifier: "SignUpMainTableCell")
    }
}

extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpMainTableCell", for: indexPath) as! SignUpMainTableCell
        cell.delegate = self
        
        cell.linkAction = {
            ModuleRouter.showPrivacyPoliticsModule(currentViewController: self)
        }
        return cell
    }
}

// MARK: - SignUpMainTableCellDelegate

extension SignUpViewController : SignUpMainTableCellDelegate {
    
    func didPressedCreateAccount() {
        ModuleRouter.showSignUpEmailModule(currentViewController: self, email: presenter.dataModel.email ?? "", password:  presenter.dataModel.password ?? "")
    }
    
    func didPressedGoogle() {
        
    }
    
    func didPressedApple() {
        
    }
    
    func didPressedPhone() {
//        ModuleRouter.showSignUpPhoneModule(currentViewController: self)
        ModuleRouter.showLogInPhoneModule(currentViewController: self, phone: nil)
    }
    
    func didPressedEnter() {
        ModuleRouter.showLogInEmailModule(currentViewController: self, email: presenter.dataModel.email)
    }
    
    func didEnterEmail(email: String) {
        presenter.dataModel.email = email
    }
    
    func didEnterPassword(password: String) {
        presenter.dataModel.password = password
    }
}

// MARK: - SignUpProtocol

extension SignUpViewController : SignUpProtocol {
    
}
