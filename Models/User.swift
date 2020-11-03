//
//  User.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/25/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import Foundation

/**
 * Represents a User.
 */
struct User: Decodable {
    
    // MARK: - Properties
    
    let login       : String
    let avatarUrl   : String
    
    var name        : String?
    var location    : String?
    var bio         : String?
    
    let publicRepos : Int
    let publicGists : Int
    
    let htmlUrl     : String
    
    let following   : Int
    let followers   : Int
    
    let createdAt   : Date
}
