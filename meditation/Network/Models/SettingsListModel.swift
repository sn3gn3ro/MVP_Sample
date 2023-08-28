//
//  SettingsListModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 27.07.2023.
//

import Foundation

struct SettingsListModel: Codable {

  var fileAnimationMorning : String? = nil
  var fileAnimationDay     : String? = nil
  var fileAnimationEvening : String? = nil
  var fileAnimationNight   : String? = nil

  enum CodingKeys: String, CodingKey {

    case fileAnimationMorning = "file_animation_morning"
    case fileAnimationDay     = "file_animation_day"
    case fileAnimationEvening = "file_animation_evening"
    case fileAnimationNight   = "file_animation_night"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    fileAnimationMorning = try values.decodeIfPresent(String.self , forKey: .fileAnimationMorning )
    fileAnimationDay     = try values.decodeIfPresent(String.self , forKey: .fileAnimationDay     )
    fileAnimationEvening = try values.decodeIfPresent(String.self , forKey: .fileAnimationEvening )
    fileAnimationNight   = try values.decodeIfPresent(String.self , forKey: .fileAnimationNight   )
 
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
