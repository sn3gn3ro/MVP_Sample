//
//  MailingPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import Foundation

protocol MailingProtocol: AnyObject {
 
}

protocol MailingPresenterProtocol: AnyObject {
    init(view: MailingProtocol, dataModel: MailingDataModel)
    
}

class MailingPresenter: MailingPresenterProtocol {
    let view: MailingProtocol
    var dataModel: MailingDataModel
    
    required init(view: MailingProtocol, dataModel: MailingDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
