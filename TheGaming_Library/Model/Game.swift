//
//  File.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-17.
//

import Foundation

struct Game: Codable {
    
    var name: String
    var descriptionRaw: String?
    var description: String?
    var released: String?
//    var genres: [Genres]
    let id: Int
    let backgroundImage: String
    var backgroundImageAdditional: String?
    
    
    
}

//struct Genres: Codable {
//    let id: Int
//    var name: String
//}

// add platforms here
// developers
// add esrb ratings

//genres
