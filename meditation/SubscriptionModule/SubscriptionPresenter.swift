//
//  SubscriptionPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 01.02.2022.
//

import Foundation

protocol SubscriptionProtocol: AnyObject {
    func dataLoad()
}

protocol SubscriptionPresenterProtocol: AnyObject {
    init(view: SubscriptionProtocol, dataModel: SubscriptionDataModel)
    func getData()
}

class SubscriptionPresenter: SubscriptionPresenterProtocol {
    weak private var view: SubscriptionProtocol?
    var dataModel: SubscriptionDataModel
    
    required init(view: SubscriptionProtocol, dataModel: SubscriptionDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func getData() {
        let _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            self.dataModel.isDataLoad = true
            self.view?.dataLoad()
        }
    }
}
