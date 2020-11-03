//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/25/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

/**
 * A Singleton which managers network calls to the GitHub API.
 */
class NetworkManager {
    
    // MARK: - Properties
    
    public static let shared    = NetworkManager()
    private let baseRequestURL  = "https://api.github.com/"
    let cache                   = NSCache<NSString,UIImage>()
    let followersPerPage        = 100
    
    
    // MARK: - Initialization
    
    private init() {
        
    }
    
    
    // MARK: - Methods
    
    /**
     * Makes a network call to the GitHub API to get a user's followers.
     */
    func getFollowers(
        for username: String,
        on page: Int,
        completed: @escaping (Result<[Follower], GFError>) -> Void
    ){
        let endpoint = baseRequestURL + "users/\(username)/followers?per_page=\(followersPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error -> Void in
            
            // --- ERROR CHECKING ---
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // --- NOW SAFE TO PARSE THE JSON ---
            do {
                let decoder                 = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers               = try decoder.decode([Follower].self, from: data)
                
                completed(.success(followers))
            }
            catch {
                completed(.failure(.invalidData))
            }
            
        })
        task.resume()
    }
    
    
    /**
     * Makes a network call to the GitHub API to get a user's info.
     */
    func getUserInfo(
        for username: String,
        completed: @escaping (Result<User, GFError>) -> Void
    ){
        let endpoint: String = baseRequestURL + "users/\(username)"
        
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error -> Void in
            
            // --- ERROR HANDLING ---
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                
                let user                        = try decoder.decode(User.self, from: data)
                
                completed(.success(user))
            }
            catch {
                completed(.failure(.invalidData))
            }
        })
        
        task.resume()
    }
    
    
    /**
     * Makes a network call to the GitHub API to get a user's avatar image.
     */
    func downloadImage(
        from urlString: String,
        completed: @escaping (UIImage?) -> Void
    ) {
        let cacheKeyFromImageURL = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKeyFromImageURL) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard let self = self,
                  error == nil,
                  let response  = response as? HTTPURLResponse, response.statusCode == 200,
                  let data      = data,
                  let image     = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKeyFromImageURL)
            
            completed(image)
            
        })
        task.resume()
    }
}
