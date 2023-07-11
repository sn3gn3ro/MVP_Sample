//
//  UserListenedListModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 29.06.2023.
//

import Foundation

struct UserListenedListModel: Codable {
    let id, user_id, lesson_id, duration_seconds: Int?
    let created_at, updated_at: String?
}
