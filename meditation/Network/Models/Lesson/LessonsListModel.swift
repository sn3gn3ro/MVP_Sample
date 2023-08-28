//
//  LessonsListModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.06.2023.
//

import Foundation

struct LessonsListModel: Codable {
    
    var currentPage  : Int?     = nil
    var data         : [LessonsListDataModel]?  = []
    var firstPageUrl : String?  = nil
    var from         : Int?     = nil
    var lastPage     : Int?     = nil
    var lastPageUrl  : String?  = nil
    var links        : [Links]? = []
    var nextPageUrl  : String?  = nil
    var path         : String?  = nil
    var perPage      : Int?     = nil
    var prevPageUrl  : String?  = nil
    var to           : Int?     = nil
    var total        : Int?     = nil
    
    enum CodingKeys: String, CodingKey {
        
        case currentPage  = "current_page"
        case data         = "data"
        case firstPageUrl = "first_page_url"
        case from         = "from"
        case lastPage     = "last_page"
        case lastPageUrl  = "last_page_url"
        case links        = "links"
        case nextPageUrl  = "next_page_url"
        case path         = "path"
        case perPage      = "per_page"
        case prevPageUrl  = "prev_page_url"
        case to           = "to"
        case total        = "total"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        currentPage  = try values.decodeIfPresent(Int.self     , forKey: .currentPage  )
        data         = try values.decodeIfPresent([LessonsListDataModel].self  , forKey: .data         )
        firstPageUrl = try values.decodeIfPresent(String.self  , forKey: .firstPageUrl )
        from         = try values.decodeIfPresent(Int.self     , forKey: .from         )
        lastPage     = try values.decodeIfPresent(Int.self     , forKey: .lastPage     )
        lastPageUrl  = try values.decodeIfPresent(String.self  , forKey: .lastPageUrl  )
        links        = try values.decodeIfPresent([Links].self , forKey: .links        )
        nextPageUrl  = try values.decodeIfPresent(String.self  , forKey: .nextPageUrl  )
        path         = try values.decodeIfPresent(String.self  , forKey: .path         )
        perPage      = try values.decodeIfPresent(Int.self     , forKey: .perPage      )
        prevPageUrl  = try values.decodeIfPresent(String.self  , forKey: .prevPageUrl  )
        to           = try values.decodeIfPresent(Int.self     , forKey: .to           )
        total        = try values.decodeIfPresent(Int.self     , forKey: .total        )
        
    }
    
    init() {
        
    }
}

struct LessonsListDataModel: Codable {
    
    var id        : Int?    = nil
    var name      : String? = nil
    var createdAt : String? = nil
    var updatedAt : String? = nil
    var paths     : Paths? = Paths()//LessonsListPathModel?  = LessonsListPathModel()
    var tags      : [Int]?  = []
    var favorite  : Bool?   = nil
    var durationSeconds: Int? = nil
    var listened: Bool? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case id        = "id"
        case name      = "name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case paths     = "paths"
        case tags      = "tags"
        case favorite  = "favorite"
        case durationSeconds = "duration_seconds"
        case listened  = "listened"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id        = try values.decodeIfPresent(Int.self    , forKey: .id        )
        name      = try values.decodeIfPresent(String.self , forKey: .name      )
        createdAt = try values.decodeIfPresent(String.self , forKey: .createdAt )
        updatedAt = try values.decodeIfPresent(String.self , forKey: .updatedAt )
        paths     = try values.decodeIfPresent(Paths.self, forKey: .paths)//(LessonsListPathModel.self  , forKey: .paths)
        tags      = try values.decodeIfPresent([Int].self  , forKey: .tags      )
        favorite  = try values.decodeIfPresent(Bool.self   , forKey: .favorite  )
        durationSeconds  = try values.decodeIfPresent(Int.self   , forKey: .durationSeconds  )
        listened  = try values.decodeIfPresent(Bool.self   , forKey: .listened  )
        
    }
    
    init() {
        
    }
}

//struct LessonsListPathModel: Codable {
//    
//    var fileAnimationMorning : FileAnimation? = FileAnimation()
//    var fileAnimationDay     : FileAnimation? = FileAnimation()
//    var fileAnimationEvening : FileAnimation? = FileAnimation()
//    var fileAnimationNight   : FileAnimation? = FileAnimation()
//    var fileAudio            : FileAnimation? = FileAnimation()
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case fileAnimationMorning = "file_animation_morning"
//        case fileAnimationDay     = "file_animation_day"
//        case fileAnimationEvening = "file_animation_evening"
//        case fileAnimationNight   = "file_animation_night"
//        case fileAudio            = "file_audio"
//        
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        
//        fileAnimationMorning = try values.decodeIfPresent(FileAnimation.self , forKey: .fileAnimationMorning )
//        fileAnimationDay     = try values.decodeIfPresent(FileAnimation.self     , forKey: .fileAnimationDay     )
//        fileAnimationEvening = try values.decodeIfPresent(FileAnimation.self , forKey: .fileAnimationEvening )
//        fileAnimationNight   = try values.decodeIfPresent(FileAnimation.self   , forKey: .fileAnimationNight   )
//        fileAudio            = try values.decodeIfPresent(FileAnimation.self            , forKey: .fileAudio            )
//        
//    }
//    
//    
//    
//    init() {
//        
//    }
//}
