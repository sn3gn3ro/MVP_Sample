//
//  SignUpPhonePresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.12.2021.
//

import Foundation

protocol SignUpPhoneProtocol: AnyObject {
    func registerComplete()
}

protocol SignUpPhonePresenterProtocol: AnyObject {
    init(view: SignUpPhoneProtocol, dataModel: SignUpPhoneDataModel)
    
    func registerUser()
}

class SignUpPhonePresenter: SignUpPhonePresenterProtocol {
    let view: SignUpPhoneProtocol
    var dataModel: SignUpPhoneDataModel
    
    required init(view: SignUpPhoneProtocol, dataModel: SignUpPhoneDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    
    func registerUser() {
        NetworkManager.register(signUpDataModel: dataModel.signUpDataModel) { [weak self] in
            self?.view.registerComplete()
        }
    }
}

