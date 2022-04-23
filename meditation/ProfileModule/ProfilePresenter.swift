//
//  ProfilePresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import Foundation

protocol ProfileProtocol: AnyObject {
 
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileProtocol, dataModel: ProfileDataModel)
    
}

class ProfilePresenter: ProfilePresenterProtocol {
    let view: ProfileProtocol
    var dataModel: ProfileDataModel
    
    required init(view: ProfileProtocol, dataModel: ProfileDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
