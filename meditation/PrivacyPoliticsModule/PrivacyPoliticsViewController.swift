//
//  PrivacyPoliticsViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 27.12.2021.
//

import UIKit

class PrivacyPoliticsViewController: UIViewController {
    
    let tableView = UITableView()
    
    var presenter: PrivacyPoliticsPresenter!
    
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
        tableView.register(PrivacyPoliticsMainTableCell.self, forCellReuseIdentifier: "PrivacyPoliticsMainTableCell")
    }

    // MARK: - Private

}

// MARK: - UITableViewDataSource

extension PrivacyPoliticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyPoliticsMainTableCell", for: indexPath) as! PrivacyPoliticsMainTableCell
        cell.delegate = self
        return cell
    }
}

// MARK: - PrivacyPoliticsMainTableCellDelegate

extension PrivacyPoliticsViewController: PrivacyPoliticsMainTableCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - PrivacyPoliticsProtocol

extension PrivacyPoliticsViewController : PrivacyPoliticsProtocol {
    
}
