//
//  SearchPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 03.02.2022.
//

import Foundation

protocol SearchProtocol: AnyObject {
 
}

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchProtocol, dataModel: SearchDataModel)
    
}

class SearchPresenter: SearchPresenterProtocol {
    let view: SearchProtocol
    var dataModel: SearchDataModel
    
    required init(view: SearchProtocol, dataModel: SearchDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}

