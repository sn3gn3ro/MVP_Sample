//
//  ModuleRouter.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit

protocol Router {
    static func setRootSignUpModule(window: UIWindow?)
    static func showSignUpEmailModule(currentViewController: UIViewController, email: String, password: String)
    static func showSignUpPhoneModule(currentViewController: UIViewController)
    static func showPrivacyPoliticsModule(currentViewController: UIViewController)
    static func showCreateEnterCodeModule(currentViewController: UIViewController)
    
    static func showLogInEmailModule(currentViewController: UIViewController, email: String?)
    static func showLogInPhoneModule(currentViewController: UIViewController, phone: String?)
    static func showRestoreEmailPasswordModule(currentViewController: UIViewController, email: String?)
    
    static func showMailingModule(currentViewController: UIViewController, email: String?)
    static func showOnboardingModule(currentViewController: UIViewController)
    
    static func showTabbarModule()
    
    static func showProfileEditModule(currentViewController: UIViewController)
    static func showFavoritesModule(currentViewController: UIViewController)
    static func showNotificationsSettingsModule(currentViewController: UIViewController)

    static func showCategoryModule(currentViewController: UIViewController)
    
    static func showPlayerModule(currentViewController: UIViewController)
    
    static func showCongratulationModule(currentViewController: UIViewController)
    static func showSubscriptionModule(currentViewController: UIViewController)
    static func showSearchModule(currentViewController: UIViewController)
}

class ModuleRouter: Router {
    static func setRootSignUpModule(window: UIWindow?) {
        guard let window = window else { return }
        let viewController = ModuleBuilder.createTabbarModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    static func showSignUpEmailModule(currentViewController: UIViewController, email: String, password: String) {
        let viewController = ModuleBuilder.createSignUpEmailModule(email: email, password: password)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showSignUpPhoneModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createSignUpPhoneModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showPrivacyPoliticsModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createPrivacyPoliticsModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showCreateEnterCodeModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createEnterCodeModule()
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
    
    static func showTabbarModule() {
        guard let window = UIApplication.shared.windows.first else { return }
        let viewController = ModuleBuilder.createTabbarModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
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
    
    static func showCategoryModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createCategoryModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showPlayerModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createPlayerModule()
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func showCongratulationModule(currentViewController: UIViewController) {
        let viewController = ModuleBuilder.createCongratulationModule()
        viewController.modalPresentationStyle = .fullScreen
//        currentViewController.navigationController?.pushViewController(viewController, animated: true)
        currentViewController.navigationController?.present(viewController, animated: true, completion: nil)
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
