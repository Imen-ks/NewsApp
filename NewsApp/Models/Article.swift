//
//  Article.swift
//  NewsApp
//
//  Created by Imen Ksouri on 04/04/2023.
//

import Foundation

struct Article: Identifiable, Codable {
    var id = UUID()
    var title: String?
    var author: String?
    var published_date: String?
    var link: String?
    var clean_url: String?
    var excerpt: String?
    var summary: String?
    var topic: String?
    var country: String?
    var language: String?
    var media: String?
}

extension Article {
    enum CodingKeys: CodingKey {
        case title, author, published_date, link, clean_url, excerpt, summary, topic, country, language, media
    }
}
