//
//  CategoryPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.01.2022.
//

import Foundation

protocol CategoryProtocol: AnyObject {
 
}

protocol CategoryPresenterProtocol: AnyObject {
    init(view: CategoryProtocol, dataModel: CategoryDataModel)
    
}

class CategoryPresenter: CategoryPresenterProtocol {
    let view: CategoryProtocol
    var dataModel: CategoryDataModel
    
    required init(view: CategoryProtocol, dataModel: CategoryDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
