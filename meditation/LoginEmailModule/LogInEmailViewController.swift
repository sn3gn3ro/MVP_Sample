//
//  LogInEmailViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import UIKit

class LogInEmailViewController: UIViewController {
    
    let tableView = UITableView()
    
    var presenter: LogInEmailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        
        setTableView()
    }

    // MARK: - Private
        
    private func isDataValidation() -> Bool {
        if !(presenter.dataModel.email?.isValidEmail() ?? false){
            return false
        }
        
        if presenter.dataModel.password == "" {
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
        tableView.register(LogInEmailMainTableCell.self, forCellReuseIdentifier: "LogInEmailMainTableCell")
    }


}

extension LogInEmailViewController: LogInEmailProtocol {
    
}

// MARK: - UITableViewDataSource

extension LogInEmailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogInEmailMainTableCell", for: indexPath) as! LogInEmailMainTableCell
        cell.delegate = self
        cell.setData(email: presenter.dataModel.email ?? "", password: presenter.dataModel.password ?? "")
        isDataValidation() ? cell.setCreateAccountActive() : cell.setCreateAccountUnactive()

        return cell
    }
}


// MARK: - SignUpMainEmailTableCellDelegate

extension LogInEmailViewController : LogInEmailMainTableCellDelegate {
    
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didPressedRestore() {
        ModuleRouter.showRestoreEmailPasswordModule(currentViewController: self, email: presenter.dataModel.email)
    }
    
    func didPressedEnter() {
        ModuleRouter.showMailingModule(currentViewController: self, email: nil)
    }
    
    
    func didEnterEmail(email: String) {
        presenter.dataModel.email = email
        tableView.reloadData()
    }
    
    func didEnterPassword(password: String) {
        presenter.dataModel.password = password
        tableView.reloadData()
    }
}
