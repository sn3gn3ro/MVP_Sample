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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.getSectionHeadVideo()
        presenter.getSection()
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
        return presenter.dataModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = presenter.dataModel.sections[section]
        switch section {
            case .main:
                return 1
            case .elements:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = presenter.dataModel.sections[indexPath.section]
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
        cell.setData(stringURL: presenter.dataModel.sectonVideoURL.link,
                     title: presenter.dataModel.dataModel?.name ?? "")
        cell.setProgress(progress: Float(presenter.dataModel.dataModel?.listenedPercent ?? 0)/100)
        
        return cell
    }
    
    private func categoryCollectionElementsTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCollectionElementsTableCell", for: indexPath) as! CategoryCollectionElementsTableCell
        cell.delegate = self
        if let lessons = presenter.dataModel.section?.lessons {
            cell.setData(lessons: lessons)
        }
//        if let lessons = presenter.dataModel.dataModel?.sectionLessons {
//            cell.setData(lessons: lessons)
//        }
    
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
    func didLoadVideo(bufferedVideo: [Int : URL]) {
        presenter.dataModel.bufferedLessonVideos = bufferedVideo
    }
    
    func didSelectElement(indexPath: IndexPath) {
        guard let lessonId = presenter.dataModel.dataModel?.sectionLessons?[indexPath.row].lessonId else { return }
        let lessons = presenter.dataModel.dataModel?.sectionLessons ?? []
        let ids = lessons.compactMap{$0.lessonId}
        let idUnfinishedMap = lessons.filter({$0.listened == false}).map({$0.lessonId ?? -1 })
        var idUnfinishedLessons = [Int: Bool]()
        for id in idUnfinishedMap {
            idUnfinishedLessons[id] = false
        }
        ModuleRouter.showPlayerModule(currentViewController: self,
                                      lessonId: lessonId,
                                      lessons: ids,
                                      lessonBufferedVideo: presenter.dataModel.bufferedLessonVideos,
                                      sectionName: presenter.dataModel.dataModel?.name,
                                      idUnfinishedLessons: idUnfinishedLessons)
    }
}

// MARK: - CategoryProtocol

extension CategoryViewController : CategoryProtocol {
    
    func didLoadHeadVideo() {
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .none)
    }
    
    func didloadSection() {
        tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .none)
    }
    
    func didLoadSectionsVideo(index: Int) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? CategoryCollectionElementsTableCell else { return }
        guard let video = presenter.dataModel.bufferedLessonVideos[index] else { return }
        cell.updateData(index: index, url: video)
    }
}
