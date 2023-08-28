//
//  ProfilePresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import Foundation
import UIKit.UIImage

protocol ProfileProtocol: AnyObject {
    func dataLoad()
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileProtocol, dataModel: ProfileDataModel)
    func getData()
    
    func uploadAvatarImage()
    func deleteAvatar()
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak private var view: ProfileProtocol?
    var dataModel: ProfileDataModel
    
    required init(view: ProfileProtocol, dataModel: ProfileDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func getData() {
        NetworkManager.getUserMe {  [weak self]  userInfo in
            self?.dataModel.userInfo = userInfo
            self?.view?.dataLoad()
//            self?.dataModel.userEmail = userInfo.email ?? ""
//            self?.dataModel.userName = userInfo.name ?? ""
//            self?.dataModel.userPhone = userInfo.phone ?? ""
        }
        getAvatar()
    }
    
    func getAvatar() {
        NetworkManager.getUserAvatar { avatarUrl in
            NetworkManager.getImage(imageUrl: avatarUrl, completion: { [weak self] image in
                self?.dataModel.userAvatar = image
                self?.view?.dataLoad()
            })
        }
    }
    
    func uploadAvatarImage() {
        NetworkManager.createUserAvatar(image: dataModel.userAvatar) {
            
        }
    }
    
    func deleteAvatar() {
        NetworkManager.deleteUserAvatar { [weak self] in
            self?.dataModel.userAvatar = UIImage(named: "userPhotoTest") ?? UIImage()
            self?.view?.dataLoad()
        }
    }
}
