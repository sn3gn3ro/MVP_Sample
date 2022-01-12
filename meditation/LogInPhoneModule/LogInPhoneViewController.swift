//
//  LogInPhoneViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import UIKit

class LogInPhoneViewController: UIViewController {

    let tableView = UITableView()
    
    var presenter: LogInPhonePresenter!

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
            make.bottom.left.right.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
        tableView.register(LogInPhoneMainTableCell.self, forCellReuseIdentifier: "LogInPhoneMainTableCell")
    }

}

// MARK: - UITableViewDataSource

extension LogInPhoneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogInPhoneMainTableCell", for: indexPath) as! LogInPhoneMainTableCell
        cell.delegate = self
        return cell
    }
}

// MARK: - LogInPhoneMainTableCellDelegate

extension LogInPhoneViewController: LogInPhoneMainTableCellDelegate {
    func didEndEnterPhone(phone: String) {
        
    }
    
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didPressedSendCode() {
        ModuleRouter.showCreateEnterCodeModule(currentViewController: self)
    }
    
    func didPressedEnter() {
        
    }
}

// MARK: - LogInPhoneProtocol

extension LogInPhoneViewController: LogInPhoneProtocol {
    
}
