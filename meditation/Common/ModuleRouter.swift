//
//  ModuleRouter.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit

protocol Router {
    static func setRootSignUpModule(window: UIWindow?)
    static func setRootTabbarModule(window: UIWindow?)
    static func showSignUpEmailModule(currentViewController: UIViewController, signUpDataModel: SignUpDataModel)
    static func showSignUpPhoneModule(currentViewController: UIViewController, signUpDataModel: SignUpDataModel)
    static func showPrivacyPoliticsModule(currentViewController: UIViewController)
    static func showEnterCodeModule(currentViewController: UIViewController, signUpDataModel: SignUpDataModel)
    
    static func showLogInEmailModule(currentViewController: UIViewController, email: String?)
    static func showLogInPhoneModule(currentViewController: UIViewController, phone: String?)
    static func showRestoreEmailPasswordModule(currentViewController: UIViewController, email: String?)
    
    static func showMailingModule(currentViewController: UIViewController, email: String?)
    static func showOnboardingModule(currentViewController: UIViewController)

    static func showProfileEditModule(currentViewController: UIViewController)
    static func showFavoritesModule(currentViewController: UIViewController)
    static func showNotificationsSettingsModule(currentViewController: UIViewController)

    static func  showCategoryModule(currentViewController: UIViewController,
                                    dataModel: DataModel,
                                    sectonVideoURL: CategoryDataModel.SectonVideoURL)
    
    static func showPlayerModule(currentViewController: UIViewController,
                                 lessonId:Int,
                                 lessons: [Int],
                                 lessonBufferedVideo: [Int:URL]?,
                                 sectionName: String?,
                                 idUnfinishedLessons: [Int: Bool]?)
    
    static func showCongratulationModule(currentViewController: UIViewController)
    static func showSubscriptionModule(currentViewController: UIViewController)
    static func showSearchModule(currentViewController: UIViewController)
}

class ModuleRouter: Router {
    
    static func setRootSignUpModule(window: UIWindow?) {
        guard let window = window else { return }
//        UserDefaultsManager.clearToken()
//        lazy var viewController = UIViewController()
//        if UserDefaultsManager.getToken() == nil {
            let viewController = ModuleBuilder.createSignUpModule()
//        } else {
//            viewController = ModuleBuilder.createTabbarModule()
//        }
//        let viewController = ModuleBuilder.createOnboardingModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    static func setRootTabbarModule(window: UIWindow?) {
        guard let window = window else { return }
        let viewController = ModuleBuilder.createTabbarModule()
//        let viewController = ModuleBuilder.createOnboardingModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    static func showSignUpEmailModule(currentViewController: UIViewController, signUpDataModel: SignUpDataModel) {
        let viewController = ModuleBuilder.createSignUpEmailModule(signUpDataModel: signUpDataModel)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showSignUpPhoneModule(currentViewController: UIViewController, signUpDataModel: SignUpDataModel) {
        let viewController = ModuleBuilder.createSignUpPhoneModule(signUpDataModel: signUpDataModel)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showPrivacyPoliticsModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createPrivacyPoliticsModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showEnterCodeModule(currentViewController: UIViewController,signUpDataModel: SignUpDataModel) {
        let viewController = ModuleBuilder.createEnterCodeModule(signUpDataModel: signUpDataModel)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showLogInEmailModule(currentViewController: UIViewController, email: String?) {
        let viewController = ModuleBuilder.createLogInEmailModule(email: email)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showLogInPhoneModule(currentViewController: UIViewController, phone: String?) {
        let viewController = ModuleBuilder.createLogInPhoneModule(phone: phone)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showRestoreEmailPasswordModule(currentViewController: UIViewController, email: String?) {
        let viewController = ModuleBuilder.createRestoreEmailPasswordModule(email: email)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showMailingModule(currentViewController: UIViewController, email: String?) {
        let viewController = ModuleBuilder.createMailingModule(email: email)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showOnboardingModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createOnboardingModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showProfileEditModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createProfileEditModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showFavoritesModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createFavoritesModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showNotificationsSettingsModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createNotificationSettingsModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showCategoryModule(currentViewController: UIViewController,
                                   dataModel: DataModel,
                                   sectonVideoURL: CategoryDataModel.SectonVideoURL) {
        let viewController = ModuleBuilder.createCategoryModule(dataModel: dataModel, sectonVideoURL: sectonVideoURL)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showPlayerModule(currentViewController: UIViewController,
                                 lessonId: Int,
                                 lessons: [Int],
                                 lessonBufferedVideo: [Int:URL]?,
                                 sectionName: String?,
                                 idUnfinishedLessons: [Int: Bool]?) {
        let viewController = ModuleBuilder.createPlayerModule(lessonId: lessonId,
                                                              lessons: lessons,
                                                              lessonBufferedVideo: lessonBufferedVideo,
                                                              sectionName: sectionName,
                                                              idUnfinishedLessons: idUnfinishedLessons) as! PlayerViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegate = currentViewController as? PlayerViewControllerDelegate
//        currentViewController.navigationController?.pushViewController(viewController, animated: true)
        currentViewController.present(viewController, animated: true)
    }
    
    static func showCongratulationModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createCongratulationModule()
        viewController.modalPresentationStyle = .fullScreen
//        currentViewController.navigationController?.pushViewController(viewController, animated: true)
//        currentViewController.navigationController?.present(viewController, animated: true, completion: nil)
        currentViewController.present(viewController, animated: true)
    }
    
    static func showSubscriptionModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createSubscriptionModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showSearchModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createSearchModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
