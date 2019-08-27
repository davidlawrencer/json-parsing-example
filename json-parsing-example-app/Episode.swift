//
//  Episode.swift
//  json-parsing-example-app
//
//  Created by David Rifkin on 8/27/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case decodingError(Error)
}

struct Episode: Codable {
    let name: String
    let summary: String
    let number: Int
    let runtime: Int
    let image: ImageWrapper
    //static let allEpisodes listed all the episodes of GOT
    
    static func getEpisodes(from data: Data) throws -> [Episode] {
        do {
            let episodes = try JSONDecoder().decode([Episode].self, from: data)
            return episodes
        } catch {
            throw JSONError.decodingError(error)
        }
    }
}

struct ImageWrapper: Codable {
    let medium: String
    let original: String
}
