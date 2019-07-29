//
//  CharacterService.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-25.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import Foundation

enum CharacterService {
    case allChars()
    case characters(name: String)
    case character(identifier: Int)
    case characterUrl(urlString: String)
    case image(urlString: String)
}

extension CharacterService: Service {
    var baseURL: String {
        return "https://rickandmortyapi.com"
    }
    
    var path: String {
        switch self {
        case .character(let identifier):
            return "/api/character/\(identifier)"
        case .allChars:
            return "/api/character"
        case .characters(_):
            return "/api/character"
        case .characterUrl(let urlString):
            let string = urlString.deletingPrefix(baseURL)
            return string
        case .image(let urlString):
            let string = urlString.deletingPrefix(baseURL)
            return string
        }
    }
    
    var parameters: [String: Any]? {
        // default params
        var params: [String: Any] = [:]
        
        switch self {
        case .characters(let name):
            params["name"] = name
        case .character(_):
            break
        case .allChars:
            break
        case .characterUrl(_):
            break
        case .image(_):
            break
        }
        return params
    }
    
    var method: ServiceMethod {
        return .get
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
