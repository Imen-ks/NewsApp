//
//  RequestParams.swift
//  NewsApp
//
//  Created by Imen Ksouri on 05/04/2023.
//

import Foundation

struct RequestParams {
    static var shared = RequestParams(
                        keyword: nil,
                        from: nil,
                        to: nil,
                        period: nil,
                        language: nil,
                        country: nil,
                        topic: nil,
                        sources: nil)
    
    let keyword: String?
    let from: String?
    let to: String?
    let period: String?
    let language: String?
    let country: String?
    let topic: String?
    let sources: String?
}

extension RequestParams {
    func updateRequestParams(keyword: String?,
                             from: String?,
                             to: String?,
                             period: String?,
                             language: String?,
                             country: String?,
                             topic: String?,
                             sources: String?) -> RequestParams {
        let keywordParam = keyword
        let fromParam = from == DateSelection.no.rawValue ? nil : from
        let toParam = to == DateSelection.no.rawValue ? nil : to
        let periodParam = period == Period.all.rawValue ? nil : period
        let languageParam = language == String(describing: Language.all) ? nil : language
        let countryParam = country == String(describing: Country.ALL) ? nil : country
        let topicParam = topic == String(describing: Topic.all) ? nil : topic
        let sourcesParam = (sources?.isEmpty ?? true) ? nil : sources
        RequestParams.shared = RequestParams(
                                keyword: keywordParam,
                                from: fromParam,
                                to: toParam,
                                period: periodParam,
                                language: languageParam,
                                country: countryParam,
                                topic: topicParam,
                                sources: sourcesParam)
        return RequestParams.shared
    }
}
