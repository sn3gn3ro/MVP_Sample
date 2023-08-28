//
//  SectionListModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 19.07.2023.
//

import Foundation

struct SectionListModel: Codable {
    
    var currentPage  : Int?     = nil
    var data         : [DataModel]?  = []
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
        data         = try values.decodeIfPresent([DataModel].self  , forKey: .data         )
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
    
}

//MARK: - Links

struct Links: Codable {
    
    var url    : String? = nil
    var label  : String? = nil
    var active : Bool?   = nil
    
    enum CodingKeys: String, CodingKey {
        case url    = "url"
        case label  = "label"
        case active = "active"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url    = try values.decodeIfPresent(String.self , forKey: .url    )
        label  = try values.decodeIfPresent(String.self , forKey: .label  )
        active = try values.decodeIfPresent(Bool.self   , forKey: .active )
    }
}

//MARK: - Data

struct DataModel: Codable {
    
    var sectionLessons : [SectionLessons]? = []
    var sort           : Int?              = nil
    var id             : Int?              = nil
    var createdAt      : String?           = nil
    var paths          : Paths?            = Paths()
    var lessons        : [Int]?            = []
    var updatedAt      : String?           = nil
    var sectionTags    : [SectionTags]?    = []
    var name           : String?           = nil
    var tags           : [Int]?            = []
    var listened       : Bool?             = nil
    var listenedPercent: Int?              = nil
    var lessonsTime    : Int?              = nil
    
    enum CodingKeys: String, CodingKey {
        
        case sectionLessons = "section_lessons"
        case sort           = "sort"
        case id             = "id"
        case createdAt      = "created_at"
        case paths          = "paths"
        case lessons        = "lessons"
        case updatedAt      = "updated_at"
        case sectionTags    = "section_tags"
        case name           = "name"
        case tags           = "tags"
        case listened       = "listened"
        case listenedPercent    = "listened_percent"
        case lessonsTime        = "lessons_time"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        sectionLessons = try values.decodeIfPresent([SectionLessons].self , forKey: .sectionLessons )
        sort           = try values.decodeIfPresent(Int.self              , forKey: .sort           )
        id             = try values.decodeIfPresent(Int.self              , forKey: .id             )
        createdAt      = try values.decodeIfPresent(String.self           , forKey: .createdAt      )
        paths          = try values.decodeIfPresent(Paths.self            , forKey: .paths          )
        lessons        = try values.decodeIfPresent([Int].self            , forKey: .lessons        )
        updatedAt      = try values.decodeIfPresent(String.self           , forKey: .updatedAt      )
        sectionTags    = try values.decodeIfPresent([SectionTags].self    , forKey: .sectionTags    )
        name           = try values.decodeIfPresent(String.self           , forKey: .name           )
        tags           = try values.decodeIfPresent([Int].self            , forKey: .tags           )
        listened        =  try values.decodeIfPresent(Bool.self            , forKey: .listened      )
        listenedPercent =  try values.decodeIfPresent(Int.self            , forKey: .listenedPercent)
        lessonsTime     =  try values.decodeIfPresent(Int.self            , forKey: .lessonsTime)
        
    }
    
    init() {
        
    }
    
}

struct SectionLessons: Codable {
    
    var id        : Int?    = nil
    var sectionId : Int?    = nil
    var lessonId  : Int?    = nil
    var updatedAt : String? = nil
    var lesson    : Lesson? = Lesson()
    var createdAt : String? = nil
    var listened : Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id        = "id"
        case sectionId = "section_id"
        case lessonId  = "lesson_id"
        case updatedAt = "updated_at"
        case lesson    = "lesson"
        case createdAt = "created_at"
        case listened = "listened"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id        = try values.decodeIfPresent(Int.self    , forKey: .id        )
        sectionId = try values.decodeIfPresent(Int.self    , forKey: .sectionId )
        lessonId  = try values.decodeIfPresent(Int.self    , forKey: .lessonId  )
        updatedAt = try values.decodeIfPresent(String.self , forKey: .updatedAt )
        lesson    = try values.decodeIfPresent(Lesson.self , forKey: .lesson    )
        createdAt = try values.decodeIfPresent(String.self , forKey: .createdAt )
        listened = try values.decodeIfPresent(Bool.self , forKey: .listened )
        
    }
    
    init() {
        
    }
}

struct Lesson: Codable {
    
    var id        : Int?    = nil
    var updatedAt : String? = nil
    var name      : String? = nil
    var createdAt : String? = nil
    var fileAnimationNight   : String? = nil
    var fileAnimationMorning : String? = nil
    var fileAnimationDay     : String? = nil
    var fileAnimationEvening : String? = nil
    var fileAudio            : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case id        = "id"
        case updatedAt = "updated_at"
        case name      = "name"
        case createdAt = "created_at"
        case fileAnimationNight   = "file_animation_night"
        case fileAnimationMorning = "file_animation_morning"
        case fileAnimationDay     = "file_animation_day"
        case fileAnimationEvening = "file_animation_evening"
        case fileAudio            = "file_audio"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id        = try values.decodeIfPresent(Int.self    , forKey: .id        )
        updatedAt = try values.decodeIfPresent(String.self , forKey: .updatedAt )
        name      = try values.decodeIfPresent(String.self , forKey: .name      )
        createdAt = try values.decodeIfPresent(String.self , forKey: .createdAt )
        fileAnimationNight   = try values.decodeIfPresent(String.self   , forKey: .fileAnimationNight   )
        fileAnimationMorning = try values.decodeIfPresent(String.self , forKey: .fileAnimationMorning )
        fileAnimationDay     = try values.decodeIfPresent(String.self     , forKey: .fileAnimationDay     )
        fileAnimationEvening = try values.decodeIfPresent(String.self , forKey: .fileAnimationEvening )
        fileAudio            = try values.decodeIfPresent(String.self, forKey: .fileAudio)
        
    }
    
    func getCurrentDayLink() -> String {
        switch DayTime.getDayTime() {
        case .morning:
            return self.fileAnimationMorning ?? ""
        case .day:
            return self.fileAnimationDay ?? ""
        case .evening:
            return self.fileAnimationEvening ?? ""
        case .night:
            return self.fileAnimationNight ?? ""
        }
    }
    
    
    init() {
        
    }
    
}

struct Paths: Codable {
    
    var fileAnimationNight   : FileAnimation?   = FileAnimation()
    var fileAnimationMorning : FileAnimation? = FileAnimation()
    var fileAnimationDay     : FileAnimation?     = FileAnimation()
    var fileAnimationEvening : FileAnimation? = FileAnimation()
    var fileAudio            : FileAnimation? = FileAnimation()
    
    enum CodingKeys: String, CodingKey {
        
        case fileAnimationNight   = "file_animation_night"
        case fileAnimationMorning = "file_animation_morning"
        case fileAnimationDay     = "file_animation_day"
        case fileAnimationEvening = "file_animation_evening"
        case fileAudio            = "file_audio"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        fileAnimationNight   = try values.decodeIfPresent(FileAnimation.self   , forKey: .fileAnimationNight   )
        fileAnimationMorning = try values.decodeIfPresent(FileAnimation.self , forKey: .fileAnimationMorning )
        fileAnimationDay     = try values.decodeIfPresent(FileAnimation.self     , forKey: .fileAnimationDay     )
        fileAnimationEvening = try values.decodeIfPresent(FileAnimation.self , forKey: .fileAnimationEvening )
        fileAudio            = try? values.decodeIfPresent(FileAnimation?.self, forKey: .fileAudio) as? FileAnimation
        
    }
    
    func getCurrentDayLink() -> String {
        switch DayTime.getDayTime() {
        case .morning:
            return self.fileAnimationMorning?.link ?? ""
        case .day:
            return self.fileAnimationDay?.link ?? ""
        case .evening:
            return self.fileAnimationEvening?.link ?? ""
        case .night:
            return self.fileAnimationNight?.link ?? ""
        }
    }
    
    init() {
        
    }
}

struct FileAnimation: Codable {
    
    var name : String? = nil
    var link : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case link = "link"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self , forKey: .name )
        link = try values.decodeIfPresent(String.self , forKey: .link )
        
    }
    
    init() {
        
    }
    
}

struct SectionTags: Codable {
    
    var createdAt : String? = nil
    var id        : Int?    = nil
    var sectionId : Int?    = nil
    var updatedAt : String? = nil
    var tag       : Tag?    = Tag()
    var tagId     : Int?    = nil
    
    enum CodingKeys: String, CodingKey {
        
        case createdAt = "created_at"
        case id        = "id"
        case sectionId = "section_id"
        case updatedAt = "updated_at"
        case tag       = "tag"
        case tagId     = "tag_id"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        createdAt = try values.decodeIfPresent(String.self , forKey: .createdAt )
        id        = try values.decodeIfPresent(Int.self    , forKey: .id        )
        sectionId = try values.decodeIfPresent(Int.self    , forKey: .sectionId )
        updatedAt = try values.decodeIfPresent(String.self , forKey: .updatedAt )
        tag       = try values.decodeIfPresent(Tag.self    , forKey: .tag       )
        tagId     = try values.decodeIfPresent(Int.self    , forKey: .tagId     )
        
    }
    
    init() {
        
    }
    
}

struct Tag: Codable {
    
    var id        : Int?    = nil
    var updatedAt : String? = nil
    var name      : String? = nil
    var createdAt : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case id        = "id"
        case updatedAt = "updated_at"
        case name      = "name"
        case createdAt = "created_at"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id        = try values.decodeIfPresent(Int.self    , forKey: .id        )
        updatedAt = try values.decodeIfPresent(String.self , forKey: .updatedAt )
        name      = try values.decodeIfPresent(String.self , forKey: .name      )
        createdAt = try values.decodeIfPresent(String.self , forKey: .createdAt )
        
    }
    
    init() {
        
    }
    
}
