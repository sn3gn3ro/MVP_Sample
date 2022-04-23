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
   
    static func createMailingModule(email: String?) -> UIViewController
    static func createOnboardingModule() -> UIViewController
    
    static func createTabbarModule() -> UIViewController
    
    static func createMainModule() -> UIViewController
    static func createCategoryModule() -> UIViewController
    static func createProfileModule() -> UIViewController
    static func createProfileEditModule() -> UIViewController
    static func createFavoritesModule() -> UIViewController
    
    static func createNotificationSettingsModule() -> UIViewController
    
    static func createPlayerModule() -> UIViewController
    static func createCongratulationModule() -> UIViewController
    static func createSubscriptionModule() -> UIViewController
    
    static func createSearchModule() -> UIViewController
    
    
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
    
    static func createMailingModule(email: String?) -> UIViewController {
        let view = MailingViewController()
        let dataModel = MailingDataModel(email: email)
        let presenter = MailingPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createOnboardingModule() -> UIViewController {
        let view = OnboardingViewController()
        let dataModel = OnboardingDataModel()
        let presenter = OnboardingPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createTabbarModule() -> UIViewController {
//        let view = CustomTabbarController()
        return CustomTabbarController()
    }
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let dataModel = MainDataModel()
        let presenter = MainPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createCategoryModule() -> UIViewController {
        let view = CategoryViewController()
        let dataModel = CategoryDataModel()
        let presenter = CategoryPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createProfileModule() -> UIViewController {
        let view = ProfileViewController()
        let dataModel = ProfileDataModel()
        let presenter = ProfilePresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
        
    }
    
    static func createProfileEditModule() -> UIViewController {
        let view = ProfileEditViewController()
        let dataModel = ProfileEditDataModel()
        let presenter = ProfileEditPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createFavoritesModule() -> UIViewController {
        let view = FavoritesViewController()
        let dataModel = FavoritesDataModel()
        let presenter = FavoritesPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createNotificationSettingsModule() -> UIViewController {
        let view = NotificationSettingsViewController()
        let dataModel = NotificationSettingsDataModel()
        let presenter = NotificationSettingsPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createPlayerModule() -> UIViewController {
        let view = PlayerViewController()
        let dataModel = PlayerDataModel()
        let presenter = PlayerPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createCongratulationModule() -> UIViewController {
        let view = CongratulationViewController()
        let dataModel = CongratulationDataModel()
        let presenter = CongratulationPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createSubscriptionModule() -> UIViewController {
        let view = SubscriptionViewController()
        let dataModel = SubscriptionDataModel()
        let presenter = SubscriptionPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
    
    static func createSearchModule() -> UIViewController {
        let view = SearchViewController()
        let dataModel = SearchDataModel()
        let presenter = SearchPresenter(view: view, dataModel: dataModel)
        view.presenter = presenter

        return view
    }
}

