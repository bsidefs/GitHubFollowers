//
//  GFError.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/26/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUsername            = "This username created an invalid request. Please try again."
    case unableToCompleteRequest    = "We were unable to complete your request. Try checking your internet connection."
    case invalidResponse            = "We received an invalid response from the server. Please try again."
    case invalidData                = "The data received from the server was invalid. Please try again."
    case unableToFavorite           = "Unable to favorite. Sorry."
    case alreadyInFavorites         = "This user is already in your favorites!"
}
