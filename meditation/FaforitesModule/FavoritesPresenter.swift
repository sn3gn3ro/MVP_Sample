//
//  FavoritesPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import Foundation

protocol FavoritesProtocol: AnyObject {
 
}

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesProtocol, dataModel: FavoritesDataModel)
    
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    let view: FavoritesProtocol
    var dataModel: FavoritesDataModel
    
    required init(view: FavoritesProtocol, dataModel: FavoritesDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}

