//
//  LogInEmailPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 10.01.2022.
//

import Foundation

protocol LogInEmailProtocol: AnyObject {
 
}

protocol LogInEmailPresenterProtocol: AnyObject {
    init(view: LogInEmailProtocol, dataModel: LogInEmailDataModel)
    
}

class LogInEmailPresenter: LogInEmailPresenterProtocol {
    let view: LogInEmailProtocol
    var dataModel: LogInEmailDataModel
    
    required init(view: LogInEmailProtocol, dataModel: LogInEmailDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
