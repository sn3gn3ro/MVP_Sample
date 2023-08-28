//
//  NotificationSettingsPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import Foundation

protocol NotificationSettingsProtocol: AnyObject {
 
}

protocol NotificationSettingsPresenterProtocol: AnyObject {
    init(view: NotificationSettingsProtocol, dataModel: NotificationSettingsDataModel)
    
}

class NotificationSettingsPresenter: NotificationSettingsPresenterProtocol {
    weak private var view: NotificationSettingsProtocol?
    var dataModel: NotificationSettingsDataModel
    
    required init(view: NotificationSettingsProtocol, dataModel: NotificationSettingsDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
}

