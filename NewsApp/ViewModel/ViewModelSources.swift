//
//  ViewModelSources.swift
//  NewsApp
//
//  Created by Imen Ksouri on 11/04/2023.
//

import Foundation

@MainActor
class ViewModelSources: ObservableObject {
    
    @Published var sourcesRequestParams: RequestParams = RequestParams.shared

    var api: Api {
        Api(parameters: [
            "lang": sourcesRequestParams.language,
            "countries": sourcesRequestParams.country,
            "topic": sourcesRequestParams.topic
        ])
    }
    
    var sources: SourcesResponse? {
        get async throws {
            try await ApiCaller.shared.load(api: api, endpoint: .sources)
        }
    }
    
    func updateParams(keyword: String? = nil,
                       from: String? = nil,
                       to: String? = nil,
                       period: String? = nil,
                       language: String?,
                       country: String?,
                       topic: String?,
                       sources: String? = nil) {
        sourcesRequestParams = sourcesRequestParams
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
