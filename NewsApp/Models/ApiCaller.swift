//
//  ApiCaller.swift
//  NewsApp
//
//  Created by Imen Ksouri on 11/04/2023.
//

import Foundation

struct ApiCaller {
    static var shared = ApiCaller()
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    enum Method: String {
        case GET, POST
    }
}

extension ApiCaller {
    func load<T: Decodable>(api: Api, endpoint: Endpoint, method: Method = .GET) async throws -> T? {
        var components = URLComponents(string: api.root + endpoint.rawValue)
        
        components?.queryItems = api.parameters.compactMapValues { $0 }.compactMap { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components?.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(api.header["x-api-key"], forHTTPHeaderField: "x-api-key")
        let (data, _) = try await session.data(for: request)
        
        return try decoder.decode(T.self, from: data)
    }
}
