//
//  CategoryViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.01.2022.
//

import UIKit
import Hero

class CategoryViewController: UIViewController {

    let tableView = UITableView()
 
    var presenter: CategoryPresenter!
    
    enum Section {
        case main
        case elements
    }
    
    let sections: [Section] = [.main,
                               .elements]
    
    struct ElementModel {
        var image: UIImage
        var name: String
    }
    
    let elements: [ElementModel] = [ElementModel(image: UIImage(named: "backNightTest") ?? UIImage(), name: "Страх выступать публично"),
                                    ElementModel(image: UIImage(named: "backNightTest") ?? UIImage(), name: "Страх выступать публично"),
                                    ElementModel(image: UIImage(named: "backNightTest") ?? UIImage(), name: "Страх выступать публично"),
                                    ElementModel(image: UIImage(named: "backNightTest") ?? UIImage(), name: "Страх выступать публично"),
                                    ElementModel(image: UIImage(named: "backNightTest") ?? UIImage(), name: "Страх выступать публично"),
                                    ElementModel(image: UIImage(named: "backNightTest") ?? UIImage(), name: "Страх выступать публично")]
    
    var cellBackImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cellBackImageView.hero.id = ""
    }
    
    // MARK: - Private
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TabbarSettings.height)
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
    
        tableView.register(CategoryMainTableCell.self, forCellReuseIdentifier: "CategoryMainTableCell")
        tableView.register(CategoryCollectionElementsTableCell.self, forCellReuseIdentifier: "CategoryCollectionElementsTableCell")
    }
}

// MARK: - UITableViewDataSource

extension CategoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .main:
                return 1
            case .elements:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .main:
                return categoryMainTableCell(indexPath: indexPath)
            case .elements:
                return categoryCollectionElementsTableCell(indexPath: indexPath)
        }
    }
    
    
    private func categoryMainTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryMainTableCell", for: indexPath) as! CategoryMainTableCell
        cell.delegate = self
        
        return cell
    }
    
    private func categoryCollectionElementsTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCollectionElementsTableCell", for: indexPath) as! CategoryCollectionElementsTableCell
        cell.setData(elements: elements)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - CategoryMainTableCellDelegate

extension CategoryViewController : CategoryMainTableCellDelegate {
    func didPressedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didPressedHeartButton() {
        
    }
        
}

// MARK: - CategoryCollectionElementsTableCellDelegate

extension CategoryViewController : CategoryCollectionElementsTableCellDelegate {
    func didSelectElement(indexPath: IndexPath, backImageView: UIImageView) {
        let element = elements[indexPath.row]
        backImageView.isHeroEnabled = true
        cellBackImageView = backImageView
        backImageView.hero.id = "playerBackground"
        let playerVC =  ModuleBuilder.createPlayerModule() as! PlayerViewController
        playerVC.hero.isEnabled = true
        playerVC.backImageView.hero.id = "playerBackground"
        playerVC.modalPresentationStyle = .fullScreen
//        self.present(playerVC, animated: true, completion: nil)
        self.present(playerVC, animated: true) {
//            Hero.shared.cancel()
//            backImageView.isHeroEnabled = false
        }
//        backImageView.isHeroEnabled = false
//        self.navigationController?.pushViewController(playerVC, animated: true)
    }
}

// MARK: - CategoryProtocol

extension CategoryViewController : CategoryProtocol {
    
}
