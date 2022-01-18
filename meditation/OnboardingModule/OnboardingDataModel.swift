//
//  OnboardingDataModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import Foundation

struct OnboardingDataModel {
    var panicAtack: Bool?
    var relationshipProblem: Bool?
    var healthFear: Bool?
    var emotions: [EmotionsWorkView.EmotionModel]?
}
