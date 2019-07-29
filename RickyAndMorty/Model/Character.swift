//
//  Character.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-26.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Character
struct Character: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin: Origin
    let location: Origin
    let image: String
    let episode: [String] // shoudl be changed to episode
    let url: String
    let created: String

    
    init(with status: String, character: Character) {
        self.id = character.id
        self.name = character.name
        self.species = character.species
        self.type = character.type
        self.origin = character.origin
        self.location = character.location
        self.image = character.image
        self.episode = character.episode
        self.url = character.url
        self.created = character.created
        self.gender = character.gender
        self.status = status
    }
}

// MARK: - Origin
struct Origin: Codable {
    let name: String
    let url: String
}

enum Status: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

