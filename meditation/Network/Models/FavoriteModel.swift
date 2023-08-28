//
//  FavoriteModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.07.2023.
//

import Foundation

struct FavoriteModel: Codable {
    
    var id        : Int?        = nil
    var userId    : Int?        = nil
    var lessonId  : Int?        = nil
    var createdAt : String?     = nil
    var updatedAt : String?     = nil
    var lesson    : Lesson?     = Lesson()
    var sections  : [Sections]? = []

    enum CodingKeys: String, CodingKey {

      case id        = "id"
      case userId    = "user_id"
      case lessonId  = "lesson_id"
      case createdAt = "created_at"
      case updatedAt = "updated_at"
      case lesson    = "lesson"
      case sections  = "sections"
    
    }

    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

      id        = try values.decodeIfPresent(Int.self        , forKey: .id        )
      userId    = try values.decodeIfPresent(Int.self        , forKey: .userId    )
      lessonId  = try values.decodeIfPresent(Int.self        , forKey: .lessonId  )
      createdAt = try values.decodeIfPresent(String.self     , forKey: .createdAt )
      updatedAt = try values.decodeIfPresent(String.self     , forKey: .updatedAt )
      lesson    = try values.decodeIfPresent(Lesson.self     , forKey: .lesson    )
      sections  = try values.decodeIfPresent([Sections].self , forKey: .sections  )
   
    }
    
    init() {
        
    }
    
    struct Sections: Codable {
        
        var id                   : Int?    = nil
         var name                 : String? = nil
         var fileAnimationMorning : String? = nil
         var fileAnimationDay     : String? = nil
         var fileAnimationEvening : String? = nil
         var fileAnimationNight   : String? = nil
         var sort                 : Int?    = nil
         var createdAt            : String? = nil
         var updatedAt            : String? = nil
         var peopleListened       : Int?    = nil
         var lessonsTime          : Int?    = nil

         enum CodingKeys: String, CodingKey {

           case id                   = "id"
           case name                 = "name"
           case fileAnimationMorning = "file_animation_morning"
           case fileAnimationDay     = "file_animation_day"
           case fileAnimationEvening = "file_animation_evening"
           case fileAnimationNight   = "file_animation_night"
           case sort                 = "sort"
           case createdAt            = "created_at"
           case updatedAt            = "updated_at"
           case peopleListened       = "people_listened"
           case lessonsTime          = "lessons_time"
         
         }

         init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)

           id                   = try values.decodeIfPresent(Int.self    , forKey: .id                   )
           name                 = try values.decodeIfPresent(String.self , forKey: .name                 )
           fileAnimationMorning = try values.decodeIfPresent(String.self , forKey: .fileAnimationMorning )
           fileAnimationDay     = try values.decodeIfPresent(String.self , forKey: .fileAnimationDay     )
           fileAnimationEvening = try values.decodeIfPresent(String.self , forKey: .fileAnimationEvening )
           fileAnimationNight   = try values.decodeIfPresent(String.self , forKey: .fileAnimationNight   )
           sort                 = try values.decodeIfPresent(Int.self    , forKey: .sort                 )
           createdAt            = try values.decodeIfPresent(String.self , forKey: .createdAt            )
           updatedAt            = try values.decodeIfPresent(String.self , forKey: .updatedAt            )
           peopleListened       = try values.decodeIfPresent(Int.self    , forKey: .peopleListened       )
           lessonsTime          = try values.decodeIfPresent(Int.self    , forKey: .lessonsTime          )
        
         }
        
        
        init() {
            
        }
        
    }
    
    struct Lesson: Codable {
        var id                   : Int?    = nil
          var name                 : String? = nil
          var fileAnimationMorning : String? = nil
          var fileAnimationDay     : String? = nil
          var fileAnimationEvening : String? = nil
          var fileAnimationNight   : String? = nil
          var fileAudio            : String? = nil
          var createdAt            : String? = nil
          var updatedAt            : String? = nil

          enum CodingKeys: String, CodingKey {

            case id                   = "id"
            case name                 = "name"
            case fileAnimationMorning = "file_animation_morning"
            case fileAnimationDay     = "file_animation_day"
            case fileAnimationEvening = "file_animation_evening"
            case fileAnimationNight   = "file_animation_night"
            case fileAudio            = "file_audio"
            case createdAt            = "created_at"
            case updatedAt            = "updated_at"
          
          }

          init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)

            id                   = try values.decodeIfPresent(Int.self    , forKey: .id                   )
            name                 = try values.decodeIfPresent(String.self , forKey: .name                 )
            fileAnimationMorning = try values.decodeIfPresent(String.self , forKey: .fileAnimationMorning )
            fileAnimationDay     = try values.decodeIfPresent(String.self , forKey: .fileAnimationDay     )
            fileAnimationEvening = try values.decodeIfPresent(String.self , forKey: .fileAnimationEvening )
            fileAnimationNight   = try values.decodeIfPresent(String.self , forKey: .fileAnimationNight   )
            fileAudio            = try values.decodeIfPresent(String.self , forKey: .fileAudio            )
            createdAt            = try values.decodeIfPresent(String.self , forKey: .createdAt            )
            updatedAt            = try values.decodeIfPresent(String.self , forKey: .updatedAt            )
         
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
}
