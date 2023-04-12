//
//  ViewModel.swift
//  NewsApp
//
//  Created by Imen Ksouri on 04/04/2023.
//

import Foundation

@MainActor
class ViewModelSearchArticles: ObservableObject {
    
    @Published var searchArticlesRequestParams: RequestParams = RequestParams.shared
    
    var api: Api {
        Api(parameters: [
            "q": (String(describing: searchArticlesRequestParams.keyword!)),
            "from": searchArticlesRequestParams.from,
            "to": searchArticlesRequestParams.to,
            "lang": searchArticlesRequestParams.language,
            "countries": searchArticlesRequestParams.country
        ])
    }
    
    var articles: ArticlesResponse? {
        get async throws {
            try await ApiCaller.shared.load(api: api, endpoint: .search)
        }
    }
    
    func updateParams(keyword: String?,
                      from: String?,
                      to: String?,
                      period: String? = nil,
                      language: String?,
                      country: String?,
                      topic: String? = nil,
                      sources: String? = nil) {
        searchArticlesRequestParams = searchArticlesRequestParams
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
