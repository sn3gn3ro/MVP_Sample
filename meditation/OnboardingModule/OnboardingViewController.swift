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

        return cell
    }
}

// MARK: - OnboardingMainTableCellDelegate

extension OnboardingViewController : OnboardingMainTableCellDelegate {
    func didSelectPanic(isPositive: Bool) {
        presenter.dataModel.panicAtack = isPositive
    }
    
    func didSelectRelashionshipProblem(isPositive: Bool) {
        presenter.dataModel.relationshipProblem = isPositive
    }
    
    func didSelectHealthFear(isPositive: Bool) {
        presenter.dataModel.healthFear = isPositive
    }
    
    func didSelectEmotions(emotions: [EmotionsWorkView.EmotionModel]) {
        presenter.dataModel.emotions = emotions
        //next Screen
    }
}

// MARK: - OnboardingProtocol

extension OnboardingViewController : OnboardingProtocol {
    
}
