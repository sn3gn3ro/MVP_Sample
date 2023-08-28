//
//  CategoryDataModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.01.2022.
//

import Foundation

struct CategoryDataModel {
    struct SectonVideoURL {
        var link: String
        var isBuffered: Bool
    }
    
    var sectonVideoURL: SectonVideoURL
    let dataModel:DataModel?
    var section: SectionModel?
    
    var bufferedLessonVideos = [Int: URL]()
    
    enum Section {
        case main
        case elements
    }
    
    let sections: [Section] = [.main,
                               .elements]
}
