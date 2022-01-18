//
//  MainPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import Foundation

protocol MainProtocol: AnyObject {
 
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainProtocol, dataModel: MainDataModel)
    
}

class MainPresenter: MainPresenterProtocol {
    let view: MainProtocol
    var dataModel: MainDataModel
    
    required init(view: MainProtocol, dataModel: MainDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
