//
//  NewsApiResponse.swift
//  NewsApp
//
//  Created by Imen Ksouri on 04/04/2023.
//

import Foundation

struct ArticlesResponse: Codable {
    var articles: [Article]
}

struct SourcesResponse: Codable {
    var sources: [String]
}
