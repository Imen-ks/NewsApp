//
//  ApiCaller.swift
//  NewsApp
//
//  Created by Imen Ksouri on 11/04/2023.
//

import Foundation
import Alamofire

struct ApiCaller {
    static var shared = ApiCaller()
    
    let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.headers.add(name: Api.apiKey, value: Api.apiValue)        
        return Session(configuration: configuration)
    }()
    
    enum Method: String {
        case GET, POST
    }
}

extension ApiCaller {
    func load<T: Decodable>(api: Api, endpoint: Endpoint, method: Method = .GET) async throws -> T? {
        var components = URLComponents(string: Api.root + endpoint.rawValue)

        components?.queryItems = api.parameters.compactMapValues { $0 }.compactMap { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components?.url else {
            return nil
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: HTTPMethod(rawValue: method.rawValue))
                .validate()
                .responseDecodable(of: T.self) { response in
                    if let data = response.value {
                        continuation.resume(returning: data)
                    }
                    if let error = response.error {
                        continuation.resume(throwing: error)
                        return
                    }
                }
        }
    }
}
