//
//  ViewModel.swift
//  NewsApp
//
//  Created by Imen Ksouri on 04/04/2023.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var searchArticlesRequestParams: RequestParams = RequestParams(keyword: nil, from: nil, to: nil, period: nil, language: nil, country: nil, topic: nil, sources: nil)
    @Published var latestHeadlinesRequestParams: RequestParams = RequestParams(keyword: nil, from: nil, to: nil, period: nil, language: nil, country: nil, topic: nil, sources: nil)
    @Published var sourcesRequestParams: RequestParams = RequestParams(keyword: nil, from: nil, to: nil, period: nil, language: nil, country: nil, topic: nil, sources: nil)
    
    let token = ProcessInfo.processInfo.environment["x-api-key"]
    
    func updateSearchArticlesRequestParams(keyword: String, from: String, to: String, language: String, country: String) {
        let keywordParam = keyword
        let fromParam = from == "no" ? nil : from
        let toParam = to == "no" ? nil : to
        let languageParam = language == "all" ? nil : language
        let countryParam = country == "ALL" ? nil : country
        let requestParams = RequestParams(keyword: keywordParam, from: fromParam, to: toParam, period: nil, language: languageParam, country: countryParam, topic: nil, sources: nil)
        searchArticlesRequestParams = requestParams
    }
    
    func loadSearchedArticles() async throws -> ArticlesResponse? {
        var components = URLComponents(string: "https://api.newscatcherapi.com/v2/search")
        
        let params = [
            "q": (String(describing: searchArticlesRequestParams.keyword!)),
            "from": searchArticlesRequestParams.from,
            "to": searchArticlesRequestParams.to,
            "lang": searchArticlesRequestParams.language,
            "countries": searchArticlesRequestParams.country
        ]
        
        var queryItems: [URLQueryItem] = []
        
        for (param, value) in params {
            if value != nil {
                queryItems.append(URLQueryItem(name: param, value: value))
            }
        }

        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            return nil
        }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "x-api-key")
        let session = URLSession.shared
        let (data, _) = try await session.data(for: request)
        
        return try JSONDecoder().decode(ArticlesResponse.self, from: data)
    }
    
    func updateLatestHeadlinesRequestParams(period: String, language: String, country: String, topic: String, sources: String) {
        let periodParam = period == "All periods" ? nil : period
        let languageParam = language == "all" ? nil : language
        let countryParam = country == "ALL" ? nil : country
        let topicParam = topic == "all" ? nil : topic
        let sourcesParam = sources.isEmpty ? nil : sources
        let requestParams = RequestParams(keyword: nil, from: nil, to: nil, period: periodParam, language: languageParam, country: countryParam, topic: topicParam, sources: sourcesParam)
        latestHeadlinesRequestParams = requestParams
    }
    
    func loadLatestHeadlines() async throws -> ArticlesResponse? {
        var components = URLComponents(string: "https://api.newscatcherapi.com/v2/latest_headlines")
        
        let params = [
            "when": latestHeadlinesRequestParams.period,
            "lang": latestHeadlinesRequestParams.language,
            "countries": latestHeadlinesRequestParams.country,
            "topic": latestHeadlinesRequestParams.topic,
            "sources": latestHeadlinesRequestParams.sources?.lowercased()
        ]
        
        var queryItems: [URLQueryItem] = []
        
        for (param, value) in params {
            if value != nil {
                queryItems.append(URLQueryItem(name: param, value: value))
            }
        }

        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            return nil
        }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "x-api-key")
        let session = URLSession.shared
        let (data, _) = try await session.data(for: request)
        
        return try JSONDecoder().decode(ArticlesResponse.self, from: data)
    }
    
    func updateSourcesRequestParams(language: String, country: String, topic: String) {
        let languageParam = language == "all" ? nil : language
        let countryParam = country == "ALL" ? nil : country
        let topicParam = topic == "all" ? nil : topic
        let requestParams = RequestParams(keyword: nil, from: nil, to: nil, period: nil, language: languageParam, country: countryParam, topic: topicParam, sources: nil)
        sourcesRequestParams = requestParams
    }
    
    func loadSources() async throws -> SourcesResponse? {
        var components = URLComponents(string: "https://api.newscatcherapi.com/v2/sources")
        
        let params = [
            "lang": sourcesRequestParams.language,
            "countries": sourcesRequestParams.country,
            "topic": sourcesRequestParams.topic
        ]
        
        var queryItems: [URLQueryItem] = []
        
        for (param, value) in params {
            if value != nil {
                queryItems.append(URLQueryItem(name: param, value: value))
            }
        }

        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            return nil
        }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "x-api-key")
        let session = URLSession.shared
        let (data, _) = try await session.data(for: request)
        
        return try JSONDecoder().decode(SourcesResponse.self, from: data)
    }
}
