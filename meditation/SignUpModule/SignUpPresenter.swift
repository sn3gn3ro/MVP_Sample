//
//  SignUpPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//


protocol SignUpProtocol: AnyObject {
 
}

protocol SignUpPresenterProtocol: AnyObject {
    init(view: SignUpProtocol, dataModel: SignUpDataModel)
    
}

class SignUpPresenter: SignUpPresenterProtocol {
    let view: SignUpProtocol
    var dataModel: SignUpDataModel
    
    required init(view: SignUpProtocol, dataModel: SignUpDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
