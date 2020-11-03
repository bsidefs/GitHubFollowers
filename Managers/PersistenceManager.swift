//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/15/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case adding, removing
}

enum PersistenceManager {
    
    // MARK: - Properties
    static private let userDefaults = UserDefaults.standard
    
    
    // MARK: - Enum Keys
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    // MARK: - Type Methods
    
    /**
     * Performs an add to or delete from persistence based on given actionType.
     */
    static func updateWith(
        favorite: Follower,
        by actionType: PersistenceActionType,
        completed: @escaping (GFError?) -> Void) {
        
        getFavorites { result in
            switch result {

                case .success(var favorites):
                    
                    switch actionType {
                    
                        case .adding:
                            guard !favorites.contains(where: { follower in
                                follower.login == favorite.login && follower.avatarUrl == favorite.avatarUrl
                            }) else {
                                completed(.alreadyInFavorites)
                                return
                            }
                            
                            favorites.append(favorite)
                            
                        case .removing:
                            favorites.removeAll { $0.login == favorite.login }
                    }
                    
                    completed(saveFavorites(favorites: favorites))
                    
                case .failure(let error):
                    completed(error)
            }
        }
        
    }
    
    
    /**
     * Gets a user's favorites from userDefaults.
     */
    static func getFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = userDefaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder     = JSONDecoder()
            let favorites   = try decoder.decode([Follower].self, from: favoritesData)
            
            completed(.success(favorites))
        }
        catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    
    /**
     * Saves a user's favorite to userDefaults.
     */
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encoder             = JSONEncoder()
            let encodedFavorites    = try encoder.encode(favorites)
            userDefaults.set(encodedFavorites, forKey: Keys.favorites)
            
            return nil
        }
        catch {
            return .unableToFavorite
        }
    }
}
