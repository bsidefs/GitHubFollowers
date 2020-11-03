//
//  FavoritesVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/23/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class FavoritesVC: GFDataLoadingVC {
    
    // MARK: - Properties
    
    var tableView           : UITableView!
    var favorites           : [Follower] = []
    var emptyStateView      : GFEmptyStateView!
    let emptyStateMessage   = "You haven't favorited anyone yet!"

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureEmptyStateView()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
    }
    
    
    // MARK: - Methods
    
    func configureViewController() {
        title                   = "Favorites"
        view.backgroundColor    = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureEmptyStateView() {
        emptyStateView = GFEmptyStateView(message: self.emptyStateMessage)
        view.addSubview(self.emptyStateView)
    }
    
    
    func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.frame             = view.bounds
        tableView.rowHeight         = 80
        tableView.backgroundColor   = .systemBackground
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    
        tableView.delegate          = self
        tableView.dataSource        = self
        
        tableView.removeExcessCells()
    }
    
    
    func getFavorites() {
        PersistenceManager.getFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let favorites):
                    self.updateUI(with: favorites)
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something Went Wrong :(", body: error.rawValue, actionTitle: "Okay")
                }
        }
    }
    
    
    func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            DispatchQueue.main.async {
                self.view.bringSubviewToFront(self.emptyStateView)
            }
        }
        else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}


// MARK: - UITableViewDelegate & DataSource

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        cell.set(favorite: self.favorites[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = self.favorites[indexPath.row]
        
        let followerListVC = FollowersListVC(username: favorite.login)
        
        self.navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], by: .removing) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
                if self.favorites.count == 0 {
                    self.view.bringSubviewToFront(self.emptyStateView)
                }
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Unable to unfavorite.", body: error.rawValue, actionTitle: "Okay")
        }
    }
}
