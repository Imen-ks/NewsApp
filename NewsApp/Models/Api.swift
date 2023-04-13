//
//  Api.swift
//  NewsApp
//
//  Created by Imen Ksouri on 11/04/2023.
//

import Foundation

struct Api {
    static let apiKey = "x-api-key"
    static let apiValue = Bundle.main.object(forInfoDictionaryKey: "X_API_KEY") as? String ?? ""
    static let root = "https://api.newscatcherapi.com/v2/"
    
    var parameters: [String: String?]
    var headers: [String: String]?
}

enum Endpoint: String {
    case search, latest_headlines, sources
}
