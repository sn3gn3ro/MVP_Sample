//
//  OnboardingPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import Foundation

protocol OnboardingProtocol: AnyObject {
    func dataLoad()
    func idsDidAccepted()
}

protocol OnboardingPresenterProtocol: AnyObject {
    init(view: OnboardingProtocol, dataModel: OnboardingDataModel)
    func getData()
    func sendIds(ids: [Int])
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    let view: OnboardingProtocol
    var dataModel: OnboardingDataModel
    
    required init(view: OnboardingProtocol, dataModel: OnboardingDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func getData() {        
        NetworkManager.getQuestionList { [weak self] questionsListModel in
            guard let `self` = self else { return }
            self.dataModel.questionsListModel = questionsListModel
            self.view.dataLoad()
        }
    }

    func sendIds(ids: [Int]) {
        NetworkManager.createUserTags(tagId: ids) { [weak self] in
            self?.view.idsDidAccepted()
        }
    }
}
