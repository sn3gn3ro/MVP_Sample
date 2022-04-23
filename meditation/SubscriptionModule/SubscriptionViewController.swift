//
//  SubscriptionViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 01.02.2022.
//

import UIKit

class SubscriptionViewController: UIViewController {

    let tableView = UITableView()
    
    var presenter: SubscriptionPresenter!

    enum Section {
        case main
        case fullWidthBigImage
        case twoOption
        case fullWidthSmallImage
        case button
    }
    
    let sections: [Section] = [.main,
                               .fullWidthBigImage,
                               .twoOption,
                               .fullWidthSmallImage,
                               .button]


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
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
    
        tableView.register(SubscriptionMainTableCell.self, forCellReuseIdentifier: "SubscriptionMainTableCell")
        tableView.register(SubscriptionFullWidthBigImageTableCell.self, forCellReuseIdentifier: "SubscriptionFullWidthBigImageTableCell")
        tableView.register(SubscriptionTwoOptionTableCell.self, forCellReuseIdentifier: "SubscriptionTwoOptionTableCell")
        tableView.register(SubscriptionFullWidthSmallImageTableCell.self, forCellReuseIdentifier: "SubscriptionFullWidthSmallImageTableCell")
        tableView.register(SubscriptionSimpleButtonTableCell.self, forCellReuseIdentifier: "SubscriptionSimpleButtonTableCell")
    }

}

// MARK: - UITableViewDataSource

extension SubscriptionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .main:
                return 1
            case .fullWidthBigImage:
                return 1
            case .twoOption:
                return 1
            case .fullWidthSmallImage:
                return 1
            case .button:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return subscriptionMainTableCell(indexPath: indexPath)
            case .fullWidthBigImage:
                return subscriptionFullWidthBigImageTableCell(indexPath: indexPath)
            case .twoOption:
                return subscriptionTwoOptionTableCell(indexPath: indexPath)
            case .fullWidthSmallImage:
                return subscriptionFullWidthSmallImageTableCell(indexPath: indexPath)
            case .button:
                return subscriptionSimpleButtonTableCell(indexPath: indexPath)
        }
    }
    
    private func subscriptionMainTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionMainTableCell", for: indexPath) as! SubscriptionMainTableCell
        cell.delegate = self
        cell.setData()
        return cell
    }
    
    private func subscriptionFullWidthBigImageTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionFullWidthBigImageTableCell", for: indexPath) as! SubscriptionFullWidthBigImageTableCell
        cell.setData()
        cell.delegate = self

        return cell
    }
    
    private func subscriptionTwoOptionTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionTwoOptionTableCell", for: indexPath) as! SubscriptionTwoOptionTableCell
        cell.setData()
        cell.delegate = self

        return cell
    }
    
    private func subscriptionFullWidthSmallImageTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionFullWidthSmallImageTableCell", for: indexPath) as! SubscriptionFullWidthSmallImageTableCell
        cell.setData()
        cell.delegate = self
        
        return cell
    }
    
    private func subscriptionSimpleButtonTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionSimpleButtonTableCell", for: indexPath) as! SubscriptionSimpleButtonTableCell
        cell.delegate = self

        return cell
    }
    
    private func showCustomAlertView(title: String, subtitle: String?, button: CustomAlertView.Button?) {
        let alertView = CustomAlertView(title: title, subtitle: subtitle, button: button)
        alertView.show(view: self.view)
    }
}

// MARK: - SubscriptionMainTableCellDelegate

extension SubscriptionViewController: SubscriptionMainTableCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - SubscriptionFullWidthBigImageTableCellDelegate

extension SubscriptionViewController: SubscriptionFullWidthBigImageTableCellDelegate {
    func didChooseBigImageSubscription() {
        showCustomAlertView(title: "Подписка на месяц", subtitle: "Действует до 18.11.22\n\nСтоимость 900 ₽", button: CustomAlertView.Button(title: "Оформить", action: {
            
        }))
    }
}

// MARK: - SubscriptionTwoOptionTableCellDelegate

extension SubscriptionViewController: SubscriptionTwoOptionTableCellDelegate {
    func didSelectSubscriptionTwoOption() {
        showCustomAlertView(title: "Срок вашей подписки\nподходит к концу", subtitle: "Текущая подписка закончится 18 ноября. Хотите продлить срок подписки еще на месяц?", button: CustomAlertView.Button(title: "Продлить подписку", action: {
            
        }))
    }
}

// MARK: - SubscriptionFullWidthSmallImageTableCell

extension SubscriptionViewController: SubscriptionFullWidthSmallImageTableCellDelegate {
    func didSelectSubscriptionSmallImage() {
        
    }
}

// MARK: - SubscriptionSimpleButtonTableCellDelegate

extension SubscriptionViewController: SubscriptionSimpleButtonTableCellDelegate {
    func didPressedButton() {
        showCustomAlertView(title: "Подписка на год\nпродлена", subtitle: nil, button: nil)
    }
}

// MARK: - SubscriptionProtocol

extension SubscriptionViewController : SubscriptionProtocol {
    
}
