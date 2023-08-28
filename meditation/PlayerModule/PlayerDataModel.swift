//
//  PlayerDataModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.01.2022.
//

import Foundation

struct PlayerDataModel {
    var lessonId: Int
    var lesson:LessonsListDataModel?
    var lessons = [Int]()
    var sectionName: String?
    var lessonBufferedVideo: [Int : URL] = [:]
    var idUnfinishedLessons = [Int: Bool]()
    
    enum ChangeDirection {
        case forvard
        case back
    }

    func indexOfCurrentLesson() -> Int {
        return lessons.firstIndex(of: lessonId) ?? 0
    }
    
    func isNextLessonExist() -> Bool {
        let currentIndex = indexOfCurrentLesson()
        return lessons.count - 1 >= currentIndex + 1
    }
    
    func isPreviousLessonExist() -> Bool {
        let currentIndex = indexOfCurrentLesson()
        return currentIndex - 1 >= 0
    }
    
    mutating func changeCurrentLesson(changeDirection: ChangeDirection) {
        let currentIndex = indexOfCurrentLesson()
        switch changeDirection {
        case .forvard:
            lessonId = lessons[currentIndex + 1]
        case .back:
            lessonId = lessons[currentIndex - 1]
        }
    }
}
