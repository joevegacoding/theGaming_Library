//
//  Games.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-08.
//

import Foundation

struct SearchResults: Codable, Hashable {
    var results: [Results]
}

struct Results: Codable, Hashable {
    
    var id: Int
    var name: String
    var backgroundImage: String
    var platforms: [Platforms]
}

struct Platforms: Codable, Hashable {

    let platform: Platform
    
    struct Platform: Codable, Hashable {
        let id: Int
        let name: String
    }
}
