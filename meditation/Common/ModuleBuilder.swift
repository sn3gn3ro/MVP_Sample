//
//  ModuleBuilder.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit

protocol Builder {
    static func createSignUpModule() -> UIViewController
    static func createSignUpEmailModule(email: String, password: String) -> UIViewController
    static func createSignUpPhoneModule() -> UIViewController
    static func createPrivacyPoliticsModule() -> UIViewController
    static func createEnterCodeModule() -> UIViewController
    
    static func createLogInEmailModule(email: String?) -> UIViewController
    static func createLogInPhoneModule(phone: String?) -> UIViewController
    static func createRestoreEmailPasswordModule(email: String?) -> UIViewController
   
}

class ModuleBuilder: Builder {

    static func createSignUpModule() -> UIViewController {
        let view = SignUpViewController()
        let dataModel = SignUpDataModel()
        let presenter = SignUpPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createSignUpEmailModule(email: String, password: String) -> UIViewController {
        let view = SignUpEmailViewController()
        let dataModel = SignUpEmailDataModel(email: email, password: password)
        let presenter = SignUpEmailPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createSignUpPhoneModule() -> UIViewController {
        let view = SignUpPhoneViewController()
        let dataModel = SignUpPhoneDataModel()
        let presenter = SignUpPhonePresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createPrivacyPoliticsModule() -> UIViewController {
        let view = PrivacyPoliticsViewController()
        let dataModel = PrivacyPoliticsDataModel()
        let presenter = PrivacyPoliticsPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createEnterCodeModule() -> UIViewController {
        let view = EnterCodeViewController()
        let dataModel = EnterCodeDataModel()
        let presenter = EnterCodePresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createLogInEmailModule(email: String?) -> UIViewController {
        let view = LogInEmailViewController()
        let dataModel = LogInEmailDataModel(email: email, password: nil)
        let presenter = LogInEmailPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createLogInPhoneModule(phone: String?) -> UIViewController {
        let view = LogInPhoneViewController()
        let dataModel = LogInPhoneDataModel(phone: phone)
        let presenter = LogInPhonePresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createRestoreEmailPasswordModule(email: String?) -> UIViewController {
        let view = RestoreEmailPasswordViewController()
        let dataModel = RestoreEmailPasswordDataModel(email: email)
        let presenter = RestoreEmailPasswordPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
}

