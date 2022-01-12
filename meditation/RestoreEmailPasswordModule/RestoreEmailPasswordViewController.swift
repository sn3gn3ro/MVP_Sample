//
//  RestoreEmailPasswordViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import UIKit

class RestoreEmailPasswordViewController: UIViewController {
    
    let tableView = UITableView()
    
    var presenter: RestoreEmailPasswordPresenter!

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
        tableView.register(RestoreEmailPasswordMainTableCell.self, forCellReuseIdentifier: "RestoreEmailPasswordMainTableCell")
    }

}

// MARK: - UITableViewDataSource

extension RestoreEmailPasswordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestoreEmailPasswordMainTableCell", for: indexPath) as! RestoreEmailPasswordMainTableCell
        cell.delegate = self
        return cell
    }
}

// MARK: - LogInPhoneMainTableCellDelegate

extension RestoreEmailPasswordViewController: RestoreEmailPasswordMainTableCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didPressedRestorePassword() {
        
    }
    
    func didEndEnterEmil(email: String) {
        
    }
}

// MARK: - LogInPhoneProtocol

extension RestoreEmailPasswordViewController: RestoreEmailPasswordProtocol {
    
}
