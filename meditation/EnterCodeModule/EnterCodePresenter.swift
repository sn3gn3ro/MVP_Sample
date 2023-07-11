//
//  EnterCodePresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 27.12.2021.
//

import Foundation

protocol EnterCodeProtocol: AnyObject {
    func codeResponced()
    func authComplete()
}

protocol EnterCodePresenterProtocol: AnyObject {
    init(view: EnterCodeProtocol, dataModel: EnterCodeDataModel)
    
    func sendCode(code: String)
    func auth()
}

class EnterCodePresenter: EnterCodePresenterProtocol {
    let view: EnterCodeProtocol
    var dataModel: EnterCodeDataModel
    
    required init(view: EnterCodeProtocol, dataModel: EnterCodeDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func sendCode(code: String) {
//       sendCode{}
        auth()
//        view.codeResponced()
    }
    
    func auth() {
        NetworkManager.auth(email: dataModel.signUpDataModel.email, password: dataModel.signUpDataModel.password) { [weak self] in
            self?.view.authComplete()
        }
    }
}
