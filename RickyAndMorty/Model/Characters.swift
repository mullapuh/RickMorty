//
//  Character.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-26.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import Foundation

// MARK: - Character
struct Characters: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin: Origin
    let location: Origin
    let image: String
    let episode: [String] // shoudl be changed to episode
    let url: String
    let created: String
}

// MARK: - Origin
struct Origin: Codable {
    let name: String
    let url: String
}

