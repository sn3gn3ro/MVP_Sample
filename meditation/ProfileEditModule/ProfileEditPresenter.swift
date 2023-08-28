//
//  ProfileEditPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit

protocol ProfileEditProtocol: AnyObject {
 
}

protocol ProfileEditPresenterProtocol: AnyObject {
    init(view: ProfileEditProtocol, dataModel: ProfileEditDataModel)
    
    func deleteProfile()
    func editUserInfo()
}

class ProfileEditPresenter: ProfileEditPresenterProtocol {
    weak var view: ProfileEditProtocol?
    var dataModel: ProfileEditDataModel
    
    required init(view: ProfileEditProtocol, dataModel: ProfileEditDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    
    func deleteProfile() {
        NetworkManager.deleteUser {
            UserDefaultsManager.clearToken()
            UserDefaultsManager.clearUserInfo()
            guard let window = UIApplication.shared.windows.first else { return }
            ModuleRouter.setRootSignUpModule(window: window)
        }
    }
    
    func editUserInfo() {
        NetworkManager.updateUser(id: dataModel.userInfo?.id ?? -1,
                                  name: dataModel.editableName,
                                  email: dataModel.editableEmail,
                                  phone: Int(dataModel.editablePhone ?? "")) {
            
        }
    }
}

