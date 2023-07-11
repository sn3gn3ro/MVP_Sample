//
//  FavoritesPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import Foundation

protocol FavoritesProtocol: AnyObject {
    func dataLoad()
}

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesProtocol, dataModel: FavoritesDataModel)
    func getData()
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    let view: FavoritesProtocol
    var dataModel: FavoritesDataModel
    
    required init(view: FavoritesProtocol, dataModel: FavoritesDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func getData() {
        self.view.dataLoad()
        let _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            self.dataModel.isDataLoad = true
            self.view.dataLoad()
        }
    }
}

