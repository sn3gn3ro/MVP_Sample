//
//  UserInfoModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 29.06.2023.
//

import Foundation

struct UserInfoModel: Codable {
    var id: Int?
    var name, email, phone, subscribe_type: String?
    var subscribe_date: String?
    var email_verified_at: String?
    var created_at, updated_at: String?
}
