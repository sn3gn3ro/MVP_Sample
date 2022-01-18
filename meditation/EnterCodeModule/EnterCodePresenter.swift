//
//  EnterCodePresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 27.12.2021.
//

import Foundation

protocol EnterCodeProtocol: AnyObject {
 
}

protocol EnterCodePresenterProtocol: AnyObject {
    init(view: EnterCodeProtocol, dataModel: EnterCodeDataModel)
    
}

class EnterCodePresenter: EnterCodePresenterProtocol {
    let view: EnterCodeProtocol
    var dataModel: EnterCodeDataModel
    
    required init(view: EnterCodeProtocol, dataModel: EnterCodeDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
