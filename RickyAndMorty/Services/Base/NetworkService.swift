//
//  NetworkService.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-25.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import Foundation

enum ServiceMethod: String {
    case get = "GET"
    // implement more when needed: post, put, delete, patch, etc.
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: ServiceMethod { get }
}

extension Service {
    public var urlRequest: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        switch method {
        case .get:
            if let params = parameters as? [String: String] {
                if params.count > 0 {
                    urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
                }
            }
        }
       
        
        return urlComponents?.url
    }
}
