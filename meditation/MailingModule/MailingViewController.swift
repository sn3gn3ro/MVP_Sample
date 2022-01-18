//
//  MailingViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit

class MailingViewController: UIViewController {

    let tableView = UITableView()
    
 
    var presenter: MailingPresenter!
    
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
        tableView.register(MailingMainTableCell.self, forCellReuseIdentifier: "MailingMainTableCell")
    }
}

// MARK: - UITableViewDataSource

extension MailingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MailingMainTableCell", for: indexPath) as! MailingMainTableCell
        cell.delegate = self

        return cell
    }
}

// MARK: - MailingMainTableCellDelegate

extension MailingViewController : MailingMainTableCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didPressedFurtherButton() {
        ModuleRouter.showOnboardingModule(currentViewController: self)
    }
    
    func didEndEnterEmil(email: String) {
        
    }
}

// MARK: - SignUpProtocol

extension MailingViewController : MailingProtocol {
    
}
