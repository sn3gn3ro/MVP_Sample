//
//  CongratulationPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 28.01.2022.
//

import Foundation

protocol CongratulationProtocol: AnyObject {
 
}

protocol CongratulationPresenterProtocol: AnyObject {
    init(view: CongratulationProtocol, dataModel: CongratulationDataModel)
    
}

class CongratulationPresenter: CongratulationPresenterProtocol {
    let view: CongratulationProtocol
    var dataModel: CongratulationDataModel
    
    required init(view: CongratulationProtocol, dataModel: CongratulationDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
