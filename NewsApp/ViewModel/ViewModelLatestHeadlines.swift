//
//  ViewModelLatestHeadlines.swift
//  NewsApp
//
//  Created by Imen Ksouri on 11/04/2023.
//

import Foundation

@MainActor
class ViewModelLatestHeadlines: ObservableObject {
    
    @Published var latestHeadlinesRequestParams: RequestParams = RequestParams.shared
    
    var api: Api {
        Api(parameters: [
            "when": latestHeadlinesRequestParams.period,
            "lang": latestHeadlinesRequestParams.language,
            "countries": latestHeadlinesRequestParams.country,
            "topic": latestHeadlinesRequestParams.topic,
            "sources": latestHeadlinesRequestParams.sources?.lowercased()
        ])
    }
    
    var articles: ArticlesResponse? {
        get async throws {
            try await ApiCaller.shared.load(api: api, endpoint: .latest_headlines)
        }
    }
    
    func updateParams(keyword: String? = nil,
                       from: String? = nil,
                       to: String? = nil,
                       period: String?,
                       language: String?,
                       country: String?,
                       topic: String?,
                       sources: String?) {
        latestHeadlinesRequestParams = latestHeadlinesRequestParams
                                        .updateRequestParams(
                                            keyword: keyword,
                                            from: from,
                                            to: to,
                                            period: period,
                                            language: language,
                                            country: country,
                                            topic: topic,
                                            sources: sources
                                        )
     }
}
