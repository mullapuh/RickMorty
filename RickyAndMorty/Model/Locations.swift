//
//  Locations.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-26.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import Foundation

// MARK: - Locations
struct Locations: Codable {
    let info: LocationInfo
    let results: [Location]
}

// MARK: - Info
struct LocationInfo: Codable {
    let count, pages: Int
    let next: String
    let prev: String
}

// MARK: - Result
struct Location: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
