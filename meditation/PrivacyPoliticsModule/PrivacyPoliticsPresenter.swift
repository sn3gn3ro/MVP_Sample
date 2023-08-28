//
//  PrivacyPoliticsPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 27.12.2021.
//

import Foundation

protocol PrivacyPoliticsProtocol: AnyObject {
 
}

protocol PrivacyPoliticsPresenterProtocol: AnyObject {
    init(view: PrivacyPoliticsProtocol, dataModel: PrivacyPoliticsDataModel)
    
}

class PrivacyPoliticsPresenter: PrivacyPoliticsPresenterProtocol {
    weak private var view: PrivacyPoliticsProtocol?
    var dataModel: PrivacyPoliticsDataModel
    
    required init(view: PrivacyPoliticsProtocol, dataModel: PrivacyPoliticsDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}

