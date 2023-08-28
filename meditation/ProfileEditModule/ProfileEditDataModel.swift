//
//  ProfileEditDataModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import Foundation

struct ProfileEditDataModel {
    var userInfo = UserDefaultsManager.getUserInfo()
    
    var editableName: String?
    var editableEmail: String?
    var editablePhone: String?
}
