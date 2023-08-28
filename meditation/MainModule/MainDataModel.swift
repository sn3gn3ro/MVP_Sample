//
//  MainDataModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import Foundation

struct MainDataModel {
    var isDataLoad = false
    var userInfoModel: UserInfoModel?
    var sectionListModel:SectionListModel?
    var userListenedListModel: UserListenedListModel?
    var settings: SettingsListModel?
    
    var bufferedSettingsVideo: URL?
    var bufferedListed: URL?
    var bufferedRecomended = [Int:URL]()
    var bufferedSection = [Int:URL]()
    
    enum Section {
        case picture
        case search
        case played
        case recomendedHeader
        case recomended
        case podcastsHeader
        case podcasts
    }
    
    var sections: [Section] = [.picture,
                               .search,
                               .played,
                               .recomendedHeader,
                               .recomended,
                               .podcastsHeader,
                               .podcasts]
}

