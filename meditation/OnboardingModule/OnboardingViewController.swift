//
//  OnboardingViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit

class OnboardingViewController: UIViewController {

    let tableView = UITableView()
    
    var presenter: OnboardingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
        
        presenter.getData()
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
        tableView.register(OnboardingMainTableCell.self, forCellReuseIdentifier: "OnboardingMainTableCell")
    }
}

// MARK: - UITableViewDataSource

extension OnboardingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnboardingMainTableCell", for: indexPath) as! OnboardingMainTableCell
        cell.delegate = self
        if let data = presenter.dataModel.questionsListModel {
            cell.setData(questionsListModel: data)
        }

        return cell
    }
}

// MARK: - OnboardingMainTableCellDelegate

extension OnboardingViewController : OnboardingMainTableCellDelegate {
    func didEndSelection(ids: [Int]) {
        presenter.sendIds(ids: ids)
    }
    
    func idsDidAccepted() {
        guard let window = UIApplication.shared.windows.first else { return }
        ModuleRouter.setRootTabbarModule(window: window)
    }
}

// MARK: - OnboardingProtocol

extension OnboardingViewController : OnboardingProtocol {
    func dataLoad() {
        tableView.reloadData()
    }
}
