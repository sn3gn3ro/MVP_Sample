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
}

class UserDefaultsManager: UserDefaultsProtocol {
    
    enum Helper {
        static let defaults = UserDefaults.standard
    }
    
    static func setToken(token: String) {
        Helper.defaults.set(token, forKey: "token")
        print("TOKEN SET  \(token)")
    }
    
    static func getToken() -> String? {
        let token = Helper.defaults.string(forKey: "token")
        if token == nil {
            print("NO TOKEN")
        }
        return token
    }
    
    static func clearToken() {
        Helper.defaults.removeObject(forKey: "token")
    }
//
//    static func setLongTapOpen(enabled :Bool) {
//        let defaults = UserDefaults.standard
//        defaults.set(enabled, forKey: "longTapOpen")
//    }
//
//    static func isLongTapOpenActive() -> Bool {
//        let defaults = UserDefaults.standard
//        return defaults.bool(forKey: "longTapOpen")
//    }
//
//    static func setIsCameraImageHide(enabled :Bool) {
//        let defaults = UserDefaults.standard
//        defaults.set(enabled, forKey: "isCameraImageHide")
//    }
//
//    static func isCameraImageHide() -> Bool {
//        let defaults = UserDefaults.standard
//        return defaults.bool(forKey: "isCameraImageHide")
//    }
//
//    static func setGatesSorting(gatesIds: [String]) {
//        UserDefaults.standard.setValue(gatesIds, forKey: "gatesSort")
//    }
//
//    static func getGatesSorting() -> [String]? {
//        return UserDefaults.standard.stringArray(forKey: "gatesSort")
//    }
//
//    static func setAuth(phone: String, loginHash: String) {
//        let defaults = UserDefaults.standard
//        defaults.set(phone, forKey: "phone")
//        defaults.set(loginHash, forKey: "hash")
//    }
//
//    static func getUserPhone() -> String {
//        let defaults = UserDefaults.standard
//        let phone = defaults.string(forKey: "phone") ?? ""
//        let clearPhone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//        return  clearPhone
//    }
//
//    static func getUserHash() -> String {
//        let defaults = UserDefaults.standard
//        return  defaults.string(forKey: "hash") ?? ""
//    }
//
//    static func clearAuth(succes: @escaping ()->()) {
//        let defaults = UserDefaults.standard
//        defaults.removeObject(forKey: "phone")
//        defaults.removeObject(forKey: "pid")
//        defaults.removeObject(forKey: "hash")
//        defaults.removeObject(forKey: "gatesSort")
//        succes()
//    }
//
//    static func setUnreadNificationsCount(count: Int) {
//        let defaults = UserDefaults.standard
//        defaults.set(count, forKey: "unreadNificationsCount")
//    }
//
//    static func getUnreadNificationsCount() -> Int {
//        let defaults = UserDefaults.standard
//        return  defaults.integer(forKey: "unreadNificationsCount")
//    }
}



