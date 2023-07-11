//
//  MainPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import Foundation

protocol MainProtocol: AnyObject {
    func dataLoad()
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainProtocol, dataModel: MainDataModel)
    
    func getData()
}

class MainPresenter: MainPresenterProtocol {
    let view: MainProtocol
    var dataModel: MainDataModel
    
    required init(view: MainProtocol, dataModel: MainDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func getData() {
        //        let _ = Timer.scheduledTimer(withTimeInterval: 7.0, repeats: false) { timer in
        //            self.dataModel.isDataLoad = true
        //            self.view.dataLoad()
        //        }
        //        NetworkManager.getListOfLessons { lesson in
        //            self.dataModel.isDataLoad = true
        //            self.view.dataLoad()
        //        }
        NetworkManager.getUserMe { userInfo in
            self.dataModel.userInfoModel = userInfo
            self.dataModel.isDataLoad = true
            self.view.dataLoad()
        }
    }
}
