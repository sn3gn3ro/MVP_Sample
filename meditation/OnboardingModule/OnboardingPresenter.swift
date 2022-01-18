//
//  OnboardingPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import Foundation

protocol OnboardingProtocol: AnyObject {
 
}

protocol OnboardingPresenterProtocol: AnyObject {
    init(view: OnboardingProtocol, dataModel: OnboardingDataModel)
    
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    let view: OnboardingProtocol
    var dataModel: OnboardingDataModel
    
    required init(view: OnboardingProtocol, dataModel: OnboardingDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}
