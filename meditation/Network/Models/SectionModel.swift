//
//  SectionModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.08.2023.
//

import Foundation

struct SectionModel: Codable {

  var paths                : Paths?         = Paths()
  var sectionTags          : [SectionTags]? = []
  var listenedPercent      : Int?           = nil
  var name                 : String?        = nil
  var listened             : Bool?          = nil
  var lessons              : [Lessons]?     = []
  var createdAt            : String?        = nil
  var lessonsTime          : Int?           = nil
  var fileAnimationDay     : String?        = nil
  var fileAnimationEvening : String?        = nil
  var sort                 : Int?           = nil
  var fileAnimationNight   : String?        = nil
  var peopleListened       : Int?           = nil
  var lessonsId            : [Int]?         = []
  var updatedAt            : String?        = nil
  var id                   : Int?           = nil
  var tags                 : [Int]?         = []
  var fileAnimationMorning : String?        = nil

  enum CodingKeys: String, CodingKey {

    case paths                = "paths"
    case sectionTags          = "section_tags"
    case listenedPercent      = "listened_percent"
    case name                 = "name"
    case listened             = "listened"
    case lessons              = "lessons"
    case createdAt            = "created_at"
    case lessonsTime          = "lessons_time"
    case fileAnimationDay     = "file_animation_day"
    case fileAnimationEvening = "file_animation_evening"
    case sort                 = "sort"
    case fileAnimationNight   = "file_animation_night"
    case peopleListened       = "people_listened"
    case lessonsId            = "lessons_id"
    case updatedAt            = "updated_at"
    case id                   = "id"
    case tags                 = "tags"
    case fileAnimationMorning = "file_animation_morning"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    paths                = try values.decodeIfPresent(Paths.self         , forKey: .paths                )
    sectionTags          = try values.decodeIfPresent([SectionTags].self , forKey: .sectionTags          )
    listenedPercent      = try values.decodeIfPresent(Int.self           , forKey: .listenedPercent      )
    name                 = try values.decodeIfPresent(String.self        , forKey: .name                 )
    listened             = try values.decodeIfPresent(Bool.self          , forKey: .listened             )
    lessons              = try values.decodeIfPresent([Lessons].self     , forKey: .lessons              )
    createdAt            = try values.decodeIfPresent(String.self        , forKey: .createdAt            )
    lessonsTime          = try values.decodeIfPresent(Int.self           , forKey: .lessonsTime          )
    fileAnimationDay     = try values.decodeIfPresent(String.self        , forKey: .fileAnimationDay     )
    fileAnimationEvening = try values.decodeIfPresent(String.self        , forKey: .fileAnimationEvening )
    sort                 = try values.decodeIfPresent(Int.self           , forKey: .sort                 )
    fileAnimationNight   = try values.decodeIfPresent(String.self        , forKey: .fileAnimationNight   )
    peopleListened       = try values.decodeIfPresent(Int.self           , forKey: .peopleListened       )
    lessonsId            = try values.decodeIfPresent([Int].self         , forKey: .lessonsId            )
    updatedAt            = try values.decodeIfPresent(String.self        , forKey: .updatedAt            )
    id                   = try values.decodeIfPresent(Int.self           , forKey: .id                   )
    tags                 = try values.decodeIfPresent([Int].self         , forKey: .tags                 )
    fileAnimationMorning = try values.decodeIfPresent(String.self        , forKey: .fileAnimationMorning )
 
  }

  init() {

  }
    
    struct Lessons: Codable {

      var listened             : Bool?   = nil
      var fileAnimationDay     : String? = nil
      var id                   : Int?    = nil
      var createdAt            : String? = nil
      var fileAnimationEvening : String? = nil
      var fileAnimationNight   : String? = nil
      var fileAudio            : String? = nil
      var updatedAt            : String? = nil
      var name                 : String? = nil
      var fileAnimationMorning : String? = nil

      enum CodingKeys: String, CodingKey {

        case listened             = "listened"
        case fileAnimationDay     = "file_animation_day"
        case id                   = "id"
        case createdAt            = "created_at"
        case fileAnimationEvening = "file_animation_evening"
        case fileAnimationNight   = "file_animation_night"
        case fileAudio            = "file_audio"
        case updatedAt            = "updated_at"
        case name                 = "name"
        case fileAnimationMorning = "file_animation_morning"
      
      }

      init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        listened             = try values.decodeIfPresent(Bool.self   , forKey: .listened             )
        fileAnimationDay     = try values.decodeIfPresent(String.self , forKey: .fileAnimationDay     )
        id                   = try values.decodeIfPresent(Int.self    , forKey: .id                   )
        createdAt            = try values.decodeIfPresent(String.self , forKey: .createdAt            )
        fileAnimationEvening = try values.decodeIfPresent(String.self , forKey: .fileAnimationEvening )
        fileAnimationNight   = try values.decodeIfPresent(String.self , forKey: .fileAnimationNight   )
        fileAudio            = try values.decodeIfPresent(String.self , forKey: .fileAudio            )
        updatedAt            = try values.decodeIfPresent(String.self , forKey: .updatedAt            )
        name                 = try values.decodeIfPresent(String.self , forKey: .name                 )
        fileAnimationMorning = try values.decodeIfPresent(String.self , forKey: .fileAnimationMorning )
     
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
