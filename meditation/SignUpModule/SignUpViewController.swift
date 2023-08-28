//
//  SignUpViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit
import SnapKit
import AuthenticationServices

class SignUpViewController: UIViewController {
    
    let tableView = UITableView()
    
 
    var presenter: SignUpPresenter!
    
    enum Section {
        case main
    }
    
    let sections: [Section] = [.main]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
    }
    
    // MARK: - Private
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()//.offset(UIApplication.shared.statusBarFrame.height)
            make.bottom.left.right.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
        tableView.register(SignUpMainTableCell.self, forCellReuseIdentifier: "SignUpMainTableCell")
    }
}

extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpMainTableCell", for: indexPath) as! SignUpMainTableCell
        cell.delegate = self
        
        cell.linkAction = {
//            ModuleRouter.showPrivacyPoliticsModule(currentViewController: self)
        }
        return cell
    }
}

// MARK: - SignUpMainTableCellDelegate

extension SignUpViewController : SignUpMainTableCellDelegate {
    
    func didPressedCreateAccount() {
//        if presenter.dataModel.isEmailValid() && presenter.dataModel.isEmailValid() {
            ModuleRouter.showSignUpEmailModule(currentViewController: self, signUpDataModel: presenter.dataModel)
//        }
    }
    
    func didPressedGoogle() {
//        let customAlertView = AccessCustomAlertView()
//        let customAlertView = ConnectionErrorView()
//        view.addSubview(customAlertView)
//        NetworkManager.passwordRestoreByCode(email: "test@test.ru", newPassword: "Ls@ZbRMACee4QY6", code: "123456") {
//
//        }
//        NetworkManager.register(signUpPhoneDataModel: SignUpPhoneDataModel(email: "test@test1.ru", password: "Ls@ZbRMACee4QY6", name: "test1", phone: "1234567890")) {
//            
//        }
    }
    
    func didPressedApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func didPressedPhone() {
//        ModuleRouter.showSignUpPhoneModule(currentViewController: self)
        ModuleRouter.showLogInPhoneModule(currentViewController: self, phone: nil)
    }
    
    func didPressedEnter() {
//        guard let email = presenter.dataModel.email else { return }
//        guard let password = presenter.dataModel.password else { return }
//        let email = "test@test.ru"
//        let password = "Ls@ZbRMACee4QY6"
//        NetworkManager.Auth(email: email, password: password) {
//
//        }
        
//        NetworkManager.getFilterOptions {
//
//        }
        ModuleRouter.showLogInEmailModule(currentViewController: self, email: presenter.dataModel.email)
    }
    
    func didEnterEmail(email: String) {
        if email.isValidEmail() {
            presenter.dataModel.email = email
        } else {
            
        }
        
    }
    
    func didEnterPassword(password: String) {
        presenter.dataModel.password = password
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension SignUpViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension SignUpViewController : ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

// MARK: - SignUpProtocol

extension SignUpViewController : SignUpProtocol {
    
}


