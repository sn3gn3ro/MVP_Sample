//
//  RestoreEmailPasswordPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import Foundation

protocol RestoreEmailPasswordProtocol: AnyObject {
 
}

protocol RestoreEmailPasswordPresenterProtocol: AnyObject {
    init(view: RestoreEmailPasswordProtocol, dataModel: RestoreEmailPasswordDataModel)
    
}

class RestoreEmailPasswordPresenter: RestoreEmailPasswordPresenterProtocol {
    let view: RestoreEmailPasswordProtocol
    var dataModel: RestoreEmailPasswordDataModel
    
    required init(view: RestoreEmailPasswordProtocol, dataModel: RestoreEmailPasswordDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
