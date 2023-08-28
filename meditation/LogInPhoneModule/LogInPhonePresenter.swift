//
//  LogInPhonePresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import Foundation

protocol LogInPhoneProtocol: AnyObject {
 
}

protocol LogInPhonePresenterProtocol: AnyObject {
    init(view: LogInPhoneProtocol, dataModel: LogInPhoneDataModel)
    
}

class LogInPhonePresenter: LogInPhonePresenterProtocol {
    weak private var view: LogInPhoneProtocol?
    var dataModel: LogInPhoneDataModel
    
    required init(view: LogInPhoneProtocol, dataModel: LogInPhoneDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
