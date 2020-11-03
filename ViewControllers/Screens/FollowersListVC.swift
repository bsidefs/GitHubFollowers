//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/24/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class FollowersListVC: GFDataLoadingVC {
    
    // MARK: - Enum
    
    enum Section {
        case main
    }
    
    
    // MARK: - Properties
    
    var username            : String!
    var page                : Int = 1
    var followers           : [Follower] = []
    var filteredFollowers   : [Follower] = []
    var isSearching         : Bool = false
    var isLoadingFollowers  : Bool = false
    var hasMoreFollowers    : Bool = true
    
    var collectionView      : UICollectionView!
    var dataSource          : UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    // MARK: - Initialization
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = self.username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureAddToFavoritesButton()
        configureCollectionView()
        configureSearchController()
        
        configureDataSource()
        getFollowers(for: self.username, on: self.page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Methods
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureAddToFavoritesButton() {
        let addToFavoritesButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped))
        navigationItem.rightBarButtonItem = addToFavoritesButton
    }

    
    @objc func addButtonTapped() {
        NetworkManager.shared.getUserInfo(for: self.username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    self.addUserToFavorites(user: user)
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something Went Wrong :(", body: error.rawValue, actionTitle: "Okay")
                }
        }
    }
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, by: .adding) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.presentGFAlertOnMainThread(title: "Success!", body: "This user has been added to your favorites! 🎉", actionTitle: "Okay!")
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Whoops!", body: error.rawValue, actionTitle: "Okay")
        }
    }
    

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.create3xFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
        collectionView.delegate = self
    }
    

    func configureSearchController() {
        let searchController                                    = UISearchController()
        navigationItem.searchController                         = searchController
        
        searchController.searchBar.placeholder                  = "Search"
        searchController.searchResultsUpdater                   = self
        searchController.obscuresBackgroundDuringPresentation   = false
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell
            
            cell?.set(follower: follower)
            
            return cell
        })
    }
    
    
    /**
    * Updates the CollectionView's data by taking snapshots of differences in our followers array.
    */
    func applySnapshot(on followers: [Follower]) {
        // create
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        
        // populate
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        // apply
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    /**
    * Makes a network call to the GitHub API through the NetworkManager.
    */
    func getFollowers(for username: String, on page: Int) {
        presentLoadingView()
        isLoadingFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, on: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
                case .success(let followers):
                    self.updateUI(with: followers)
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something Went Wrong :(", body: error.rawValue, actionTitle: "Okay")
            }
            self.isLoadingFollowers = false
        }
    }
    
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        
        self.followers.append(contentsOf: followers)
        
        if (self.followers.isEmpty) {
            let message = "This user doesn't appear to have any followers."
            
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message)
            }
            return
        }
        
        self.applySnapshot(on: self.followers)
    }
}


// MARK: - Extension - UICollectionViewDelegate

extension FollowersListVC: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height          = scrollView.frame.size.height
        let contentHeight   = scrollView.contentSize.height
        let offsetY         = scrollView.contentOffset.y
        
        if offsetY > (contentHeight - height) {
            guard self.hasMoreFollowers, !isLoadingFollowers else { return }
            
            page += 1
            getFollowers(for: username, on: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredFollowers : followers
        let follower        = activeArray[indexPath.item]
        
        let userInfoVC      = UserInfoVC()
        userInfoVC.username = follower.login
        userInfoVC.delegate = self
        
        // modal
        //let navController = UINavigationController(rootViewController: userInfoVC)
        //self.present(navController, animated: true)
        
        // full screen
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
}


// MARK: - Extension - UISearch Delegate

extension FollowersListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            applySnapshot(on: self.followers)
            self.isSearching = false
            return
        }
        
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        
        isSearching = true
        applySnapshot(on: filteredFollowers)
    }
}


// MARK: - Extension - Our Other Delegate Delegation

extension FollowersListVC: UserInfoVCDelegate {
    
    /**
     * Makes a request to get the followers of a different user (not the one searched for at the SearchVC).
     */
    func didRequestFollowers(for user: User) {
        username    = user.login
        title       = user.login
        
        page        = 0
        isSearching = false
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        
        getFollowers(for: self.username, on: self.page)
    }
}
