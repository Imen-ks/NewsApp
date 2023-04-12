//
//  Api.swift
//  NewsApp
//
//  Created by Imen Ksouri on 11/04/2023.
//

import Foundation

struct Api {
    let root: String = "https://api.newscatcherapi.com/v2/"
    var parameters: [String: String?]
    var header: [String: String] = ["x-api-key": Bundle.main.object(forInfoDictionaryKey: "X_API_KEY") as? String ?? ""]
}

enum Endpoint: String {
    case search, latest_headlines, sources
}
