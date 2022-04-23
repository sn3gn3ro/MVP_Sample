//
//  PlayerPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.01.2022.
//

import Foundation

protocol PlayerProtocol: AnyObject {
 
}

protocol PlayerPresenterProtocol: AnyObject {
    init(view: PlayerProtocol, dataModel: PlayerDataModel)
    
}

class PlayerPresenter: PlayerPresenterProtocol {
    let view: PlayerProtocol
    var dataModel: PlayerDataModel
    
    required init(view: PlayerProtocol, dataModel: PlayerDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}

