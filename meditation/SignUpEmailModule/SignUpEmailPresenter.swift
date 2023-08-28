//
//  SignUpEmailPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.12.2021.
//

import Foundation

protocol SignUpEmailProtocol: AnyObject {
 
}

protocol SignUpEmailPresenterProtocol: AnyObject {
    init(view: SignUpEmailProtocol, dataModel: SignUpEmailDataModel)
    
}

class SignUpEmailPresenter: SignUpEmailPresenterProtocol {
    weak private var view: SignUpEmailProtocol?
    var dataModel: SignUpEmailDataModel
    
    required init(view: SignUpEmailProtocol, dataModel: SignUpEmailDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
