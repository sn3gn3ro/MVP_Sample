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
}

class ModuleRouter: Router {
    static func setRootSignUpModule(window: UIWindow?) {
        guard let window = window else { return }
        let viewController = ModuleBuilder.createSignUpModule()
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
}
