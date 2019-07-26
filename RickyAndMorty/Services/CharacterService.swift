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
}

extension CharacterService: Service {
    var baseURL: String {
        return "https://rickandmortyapi.com/api/character"
    }
    
    var path: String {
        switch self {
        case .character(let identifier):
            return "/\(identifier)"
        case .allChars:
            return ""
        case .characters(_):
            return ""
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
        }
        return params
    }
    
    var method: ServiceMethod {
        return .get
    }
}
