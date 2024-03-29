//
//  SignUpEmailViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.12.2021.
//

import UIKit
import SnapKit

class SignUpEmailViewController: UIViewController {
    
    let tableView = UITableView()
    
    var presenter:SignUpEmailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        
        setTableView()
    }

    // MARK: - Private
    
    private func isDataValidation() -> Bool {
        if let email = presenter.dataModel.signUpDataModel.email, !email.isValidEmail() {
            return false
        }
        
        if presenter.dataModel.signUpDataModel.password == "" {
            return false
        }
        
        if presenter.dataModel.signUpDataModel.name == "" || presenter.dataModel.signUpDataModel.name == nil {
            return false
        }
        
        return true
    }

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
        tableView.register(SignUpMainEmailTableCell.self, forCellReuseIdentifier: "SignUpMainEmailTableCell")
    }
}

// MARK: - UITableViewDataSource

extension SignUpEmailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpMainEmailTableCell", for: indexPath) as! SignUpMainEmailTableCell
        cell.delegate = self
        cell.setData(email: presenter.dataModel.signUpDataModel.email, password: presenter.dataModel.signUpDataModel.password)
        isDataValidation() ? cell.setCreateAccountActive() : cell.setCreateAccountUnactive()

        return cell
    }
}

// MARK: - SignUpMainEmailTableCellDelegate

extension SignUpEmailViewController : SignUpMainEmailTableCellDelegate {
    
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didPressedCreateAccount() {
        ModuleRouter.showSignUpPhoneModule(currentViewController: self,
                                           signUpDataModel: presenter.dataModel.signUpDataModel)
    }
    
    func didPressedEnter() {
        
    }
    
    func didEnterName(name: String) {
        presenter.dataModel.signUpDataModel.name = name
        tableView.reloadData()
    }
    
    func didEnterEmail(email: String) {
        presenter.dataModel.signUpDataModel.email = email
        tableView.reloadData()
    }
    
    func didEnterPassword(password: String) {
        presenter.dataModel.signUpDataModel.password = password
        tableView.reloadData()
    }
    
    func didEnterComfirmPassword(password: String) {
        presenter.dataModel.passwordComfirm = password
    }
}

// MARK: - SignUpEmailProtocol

extension SignUpEmailViewController:  SignUpEmailProtocol {
    
}
