//
//  SubscriptionPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 01.02.2022.
//

import Foundation

protocol SubscriptionProtocol: AnyObject {
 
}

protocol SubscriptionPresenterProtocol: AnyObject {
    init(view: SubscriptionProtocol, dataModel: SubscriptionDataModel)
    
}

class SubscriptionPresenter: SubscriptionPresenterProtocol {
    let view: SubscriptionProtocol
    var dataModel: SubscriptionDataModel
    
    required init(view: SubscriptionProtocol, dataModel: SubscriptionDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
