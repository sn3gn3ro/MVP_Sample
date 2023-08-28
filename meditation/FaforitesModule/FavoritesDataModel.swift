//
//  FavoritesDataModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import Foundation

struct FavoritesDataModel {
    var favoriteModel:[FavoriteModel]?
    var bufferedVideos: [Int:URL] = [:]
    
    mutating func clear() {
        favoriteModel = nil
        bufferedVideos.removeAll()
    }
}
