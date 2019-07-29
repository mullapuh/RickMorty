//
//  Episodes.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-26.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import Foundation

// MARK: - Episodes
struct Episodes: Codable {
    let info: EpisodeInfo
    let results: [Episode]
}

// MARK: - Info
struct EpisodeInfo: Codable {
    let count, pages: Int
    let next: String
    let prev: String
}

// MARK: - Result
struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
