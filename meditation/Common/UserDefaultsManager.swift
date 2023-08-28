//
//  UserDefaultsManager.swift
//  meditation
//
//  Created by Ilya Medvedev on 30.05.2023.
//

import UIKit

protocol UserDefaultsProtocol: AnyObject {
    static func setToken(token: String)
    static func getToken() -> String?
    static func clearToken()
    
    static func setUserInfo(info: Data)
    static func getUserInfo() -> UserInfoModel?
    static func clearUserInfo()
}

class UserDefaultsManager: UserDefaultsProtocol {
    
//    enum Helper {
//        static let defaults = UserDefaults.standard
//    }
//
    static func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
        print("TOKEN SET  \(token)")
    }
    
    static func getToken() -> String? {
        let token = UserDefaults.standard.string(forKey: "token")
        if token == nil {
            print("NO TOKEN")
        }
        return token
    }
    
    static func clearToken() {
        UserDefaults.standard.removeObject(forKey: "token")
    }
    
    static func setUserInfo(info: Data) {
        UserDefaults.standard.set(info, forKey: "userInfo")
        print("UserInfo SET")
    }
    
    static func getUserInfo() -> UserInfoModel? {
        guard let data = UserDefaults.standard.data(forKey: "userInfo") else {
            print("no UserInfo data")
            return nil
        }
        guard let userInfoModel = try? JSONDecoder().decode(UserInfoModel.self, from: data) else {
            print("no UserInfo")
            return nil
        }
        return userInfoModel
    }
    
    static func clearUserInfo() {
        UserDefaults.standard.removeObject(forKey: "userInfo")
    }
}



