//
//  DayTime.swift
//  meditation
//
//  Created by Ilya Medvedev on 07.08.2023.
//

import Foundation

final class DayTime {
    
    enum DayTime {
        case morning
        case day
        case evening
        case night
    }
    
    static func getDayTime() -> DayTime {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        guard let date = Int(formatter.string(from: Date())) else {return .night}
        switch date {
        case 0...5:
            return .night
        case 6...11:
            return .morning
        case 12...17:
            return .day
        case 18...23:
            return .evening
        default:
            return .night
        }
    }
}
