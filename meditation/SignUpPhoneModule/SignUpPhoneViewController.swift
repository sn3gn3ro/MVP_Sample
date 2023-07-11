//
//  SignUpPhoneViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.12.2021.
//

import UIKit

class SignUpPhoneViewController: UIViewController {
    
    let tableView = UITableView()
    
    var presenter: SignUpPhonePresenter!

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
        tableView.register(SignUpPhoneMainTableCell.self, forCellReuseIdentifier: "SignUpPhoneMainTableCell")
    }

}

// MARK: - UITableViewDataSource

extension SignUpPhoneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpPhoneMainTableCell", for: indexPath) as! SignUpPhoneMainTableCell
        cell.delegate = self
        return cell
    }
}

// MARK: - SignUpPhoneMainTableCellDelegate

extension SignUpPhoneViewController: SignUpPhoneMainTableCellDelegate {
    func didEndEnterPhone(phone: String) {
        presenter.dataModel.signUpDataModel.phone = phone
    }
    
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didPressedSendCode() {
        presenter.registerUser()
    }
    
    func didPressedEnter() {
        ModuleRouter.showLogInEmailModule(currentViewController: self, email:  presenter.dataModel.signUpDataModel.email)
    }
}

// MARK: - SignUpPhoneProtocol

extension SignUpPhoneViewController: SignUpPhoneProtocol {
    func registerComplete() {
        ModuleRouter.showEnterCodeModule(currentViewController: self, signUpDataModel: presenter.dataModel.signUpDataModel)
    }
}
