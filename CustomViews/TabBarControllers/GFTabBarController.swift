//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/17/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        self.viewControllers            = [createSearchNC(), createFavoritesNC()]
    }
    
    
    // MARK: - Methods
    
    /**
     * Creates a "Search" View Controller and embeds it in a UINavigationController.
     */
    func createSearchNC() -> UINavigationController {
        let searchNC        = SearchVC()
        
        searchNC.title      = "Search"
        searchNC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchNC)
    }
    
    
    /**
    * Creates a "Favorites" View Controller and embeds it in a UINavigationController.
    */
    func createFavoritesNC() -> UINavigationController {
        let favoritesNC         = FavoritesVC()
        
        favoritesNC.title       = "Favorites"
        favoritesNC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesNC)
    }
    
}
