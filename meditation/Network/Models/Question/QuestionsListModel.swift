//
//  QuestionsListModel.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.06.2023.
//

import Foundation
import UIKit

struct QuestionsListModel: Decodable {
    let currentPage: Int?
    let data: [QuestionsListDataModel]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [QuestionsListLinkModel]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?
}

// MARK: - Datum
struct QuestionsListDataModel:Decodable {
    let id: Int?
    let name, description: String?
    let sort: Int?
    let createdAt, updatedAt: String?
    let images: [QuestionsListDataImageModel]?
    let multiple: Int?
}

// MARK: - Image
struct QuestionsListDataImageModel:Decodable {
    let id: Int?
    let name: String?
    let questionID: Int?
    let image: String?
    let sort: Int?
    let createdAt, updatedAt: String?
//    var imageP: UIImage?
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case questionID
//        case image
//        case sort
//        case createdAt
//        case updatedAt
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(Int?.self, forKey: .id)
//        name = try values.decode(String?.self, forKey: .name)
//        questionID = try values.decode(Int?.self, forKey: .questionID)
//        image = try values.decode(String?.self, forKey: .image)
//        sort = try values.decode(Int?.self, forKey: .sort)
//        createdAt = try values.decode(String?.self, forKey: .createdAt)
//        updatedAt = try values.decode(String?.self, forKey: .updatedAt)
//    }

}

// MARK: - Link
struct QuestionsListLinkModel:Decodable {
    let url: String?
    let label: String?
    let active: Bool?
}
//struct QuestionsListModel: Decodable {
//    var currentPage: Int?
//    var data: [QuestionsListDataModel]?
//    var first_page_url: String?
//    var from: Int?
//    var last_page: Int?
//    var last_page_url: String?
//    var links: [QuestionsListLinksModel]?
//    var next_page_url: String?
//    var path: String?
//    var per_page: String?
//    var prev_page_url: String?
//    var to: Int?
//    var total: Int?
//
////    enum CodingKeys: String, CodingKey {
////        case current_page
////        case data
////    }
////
////    init(from decoder: Decoder) throws {
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////        currentPage = try container.decode(Int?.self, forKey: .current_page)
////        data = try container.decode([QuestionsListDataModel]?.self, forKey: .data)
////    }
//
//    struct QuestionsListDataModel: Decodable {
//        var id: Int?
//        var name: String?
//        var description: String?
//        var sort: Int?
//        var created_at: String?
//        var updated_at: String?
//        var images: [QuestionsListDataImageModel]?
//    }
//
//    struct QuestionsListLinksModel: Decodable {
//        var url: String?
//        var label: String?
//        var active: Bool?
//    }
//
//    struct QuestionsListDataImageModel: Decodable {
//        var id: Int?
//        var name: String?
//        var question_id: Int?
//        var image: String?
//        var sort: Int?
//        var created_at: Int?
//        var updated_at: Int?
//    }
//}

//    {"current_page":1,"data":[{"id":1,"name":"\u0422\u044b \u043a\u0430\u043a\u043e\u0439 \u0441\u0435\u0433\u043e\u0434\u043d\u044f \u043d\u0435 \u043e\u0434\u0438\u043d \u0434\u043e\u043c\u0430?","description":"\u041d\u0430\u0436\u043c\u0438 \u043d\u0430 \u043a\u0430\u0440\u0442\u0438\u043d\u043a\u0443 \u0434\u0430\u0436\u0435 \u0434\u0430\u0436\u0438","sort":100,"created_at":"03-05-2023 19:05:35","updated_at":"14-06-2023 08:48:43","images":[{"id":1,"name":"\u041f\u043e \u043a\u0430\u0439\u0444\u0443","question_id":1,"image":"public\/image\/g0IOZDScLwjmX0u9AvEofQSqqIiSK0eQepstZuqH.jpg","sort":100,"created_at":"2023-05-03T19:05:35.000000Z","updated_at":"2023-05-03T19:05:35.000000Z"},{"id":2,"name":"\u0427\u0435 \u0442\u0430 \u0441\u0443\u0435\u0442\u0430","question_id":1,"image":"public\/image\/jSJ1XGdfu7UDYgq3jAn6xECgNn0KTdY3FRXUTGeE.jpg","sort":200,"created_at":"2023-05-03T19:05:35.000000Z","updated_at":"2023-05-03T19:05:35.000000Z"}]},{"id":2,"name":"\u0421 \u043a\u0430\u043a\u0438\u043c\u0438 \u044d\u043c\u043e\u0446\u0438\u044f\u043c\u0438 \u0432\u044b \u0431\u044b \u0445\u043e\u0442\u0435\u043b\u0438 \u043f\u043e\u0440\u0430\u0431\u043e\u0442\u0430\u0442\u044c?","description":"\u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u043f\u043e\u0434\u0445\u043e\u0434\u044f\u0449\u0438\u0439 \u043e\u0442\u0432\u0435\u0442 \u043d\u0438\u0436\u0435. \u041a\u0430\u043a\u0430\u044f \u0438\u0437 \u043a\u0430\u0440\u0442\u0438\u043d\u043e\u043a \u0431\u043e\u043b\u044c\u0448\u0435 \u043e\u0442\u043e\u0431\u0440\u0430\u0436\u0430\u0435\u0442 \u0432\u0430\u0448\u0435 \u0441\u043e\u0441\u0442\u043e\u044f\u043d\u0438\u0435?","sort":200,"created_at":"04-05-2023 05:59:24","updated_at":"14-06-2023 08:48:43","images":[{"id":3,"name":"\u0420\u0430\u0434\u043e\u0441\u0442\u044c","question_id":2,"image":"public\/image\/4ZN3kxxOF4Yrbj2y3nNdTrCMsMASmK6WxeAouINH.jpg","sort":10,"created_at":"2023-05-04T05:59:24.000000Z","updated_at":"2023-05-04T05:59:24.000000Z"},{"id":4,"name":"\u041f\u0435\u0447\u0430\u043b\u044c","question_id":2,"image":"public\/image\/MkklxO3z8MONDOzmylQdY7tO93QwwwFtU1zc3fzr.jpg","sort":20,"created_at":"2023-05-04T05:59:24.000000Z","updated_at":"2023-05-04T05:59:24.000000Z"}]}],"first_page_url":"http:\/\/srv46749.ht-test.ru\/api\/question\/list?page=1","from":1,"last_page":1,"last_page_url":"http:\/\/srv46749.ht-test.ru\/api\/question\/list?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"http:\/\/srv46749.ht-test.ru\/api\/question\/list?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"http:\/\/srv46749.ht-test.ru\/api\/question\/list","per_page":10,"prev_page_url":null,"to":2,"total":2}
