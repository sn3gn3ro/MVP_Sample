//
//  ProfileEditPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import Foundation

protocol ProfileEditProtocol: AnyObject {
 
}

protocol ProfileEditPresenterProtocol: AnyObject {
    init(view: ProfileEditProtocol, dataModel: ProfileEditDataModel)
    
}

class ProfileEditPresenter: ProfileEditPresenterProtocol {
    let view: ProfileEditProtocol
    var dataModel: ProfileEditDataModel
    
    required init(view: ProfileEditProtocol, dataModel: ProfileEditDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}

