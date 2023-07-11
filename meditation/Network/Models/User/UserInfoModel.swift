//
//  UserInfoModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 29.06.2023.
//

import Foundation

struct UserInfoModel: Codable {
    let id: Int?
    let name, email, phone, subscribe_type: String?
    let subscribe_date: String?
    let email_verified_at: String?
    let created_at, updated_at: String?
}
