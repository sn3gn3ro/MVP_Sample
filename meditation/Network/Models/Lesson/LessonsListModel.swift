//
//  LessonsListModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.06.2023.
//

import Foundation

struct LessonsListModel: Decodable {
    var currentPage: Int?
    var data: [LessonsListDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case current_page
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentPage = try container.decode(Int?.self, forKey: .current_page)
        data = try container.decode([LessonsListDataModel]?.self, forKey: .data)
    }
  
    struct LessonsListDataModel: Decodable {
        var id: Int?
        var name: String?
        var created_at: String?
        var updated_at: String?
        var first_page_url: String?
        var from: String?
        var last_page: String?
        var last_page_url: String?
        var links: [LessonsListDataLinksModel]?
        var next_page_url: String?
        var path: String?
        var per_page: Int?
        var prev_page_url: String?
        var to: String?
        var total: String?
    }
    
    struct LessonsListDataLinksModel: Decodable {
        var url: String?
        var label: String?
        var active: String?
    }
}

// {"current_page":1,"data":[{"id":1,"name":"\u041f\u043e \u0431\u0440\u0430\u0442\u0441\u043a\u0438 \u0447\u0435 \u0441\u0442\u0430\u043b\u043e?","created_at":"03-05-2023 18:59:09","updated_at":"03-05-2023 18:59:09"}],"first_page_url":"http:\/\/srv46749.ht-test.ru\/api\/lesson\/list?page=1","from":1,"last_page":1,"last_page_url":"http:\/\/srv46749.ht-test.ru\/api\/lesson\/list?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"http:\/\/srv46749.ht-test.ru\/api\/lesson\/list?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"http:\/\/srv46749.ht-test.ru\/api\/lesson\/list","per_page":10,"prev_page_url":null,"to":1,"total":1}
