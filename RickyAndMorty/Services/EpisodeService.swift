//
//  EpisodeService.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-25.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import Foundation

enum EpisodeService {
    case allEpisodes()
    case episodeFor(name: String)
    case episode(identifier: Int)
    case episodes(identifiers: [Int])
}

extension EpisodeService: Service {
    var baseURL: String {
        return "https://rickandmortyapi.com/api/episode"
    }
    
    var path: String {
        switch self {
        case .episode(let identifier):
            return "/\(identifier)"
        case .allEpisodes:
            return ""
        case .episodeFor(_):
            return ""
        case .episodes(let identifiers):
            guard identifiers.count > 0 else { return "" }
            
            guard identifiers.count > 1 else {
                return "/\(identifiers[0])"
            }
            
            let stringInts = identifiers.map { "\($0)" }
            let joinedString = stringInts.joined(separator: ",")
            return "\(joinedString)"
            
        }
    }
    
    var parameters: [String: Any]? {
        // default params
        var params: [String: Any] = [:]
        
        switch self {
        case .episodeFor(let name):
            params["name"] = name
        case .episode(_):
            break
        case .allEpisodes():
            break
        case .episodes(_):
            break
        }
        return params
    }
    
    var method: ServiceMethod {
        return .get
    }
}
