//
//  Follower.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/25/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import Foundation

/**
 * Represents a Follower.
 */
struct Follower: Codable, Hashable, Identifiable {
    
    // MARK: - Properties
    
    var login       : String
    var avatarUrl   : String
    
    let id = UUID()
}


// MARK: - Extension

extension Follower {
    
    private enum CodingKeys: CodingKey {
        // raw values can be used here as an alternative to keyDecodingStrategy = .convertFromSnakeCase
        case login
        case avatarUrl
    }
}
