//
//  ProfilePresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import Foundation

protocol ProfileProtocol: AnyObject {
    func dataLoad()
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileProtocol, dataModel: ProfileDataModel)
    func getData()
}

class ProfilePresenter: ProfilePresenterProtocol {
    let view: ProfileProtocol
    var dataModel: ProfileDataModel
    
    required init(view: ProfileProtocol, dataModel: ProfileDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func getData() {
        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.dataModel.isDataLoad = true
            self.view.dataLoad()
        }
    }
}
