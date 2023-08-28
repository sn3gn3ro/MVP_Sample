//
//  ProfileDataModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit.UIImage

struct ProfileDataModel {
//    var isDataLoad = false
//    var userName: String = ""
//    var userEmail: String = ""
//    var userPhone: String = ""
    var userAvatar: UIImage = UIImage(named: "userPhotoTest") ?? UIImage()
    var userInfo: UserInfoModel?
    
    enum Section {
        case main
        case settings(types:[ProfileSettingTableCell.Setting])
        case exit
    }
    
    let sections: [Section] = [.main,
                               .settings(types: [ProfileSettingTableCell.Setting.favoritesLessons,
                                                 ProfileSettingTableCell.Setting.subscription,
                                                 ProfileSettingTableCell.Setting.notifications,
                                                 ProfileSettingTableCell.Setting.review]),
                               .exit]

}
