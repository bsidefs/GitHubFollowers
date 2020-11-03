//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/10/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    
    // MARK: - Properties
    weak var delegate: GFRepoItemVCDelegate!
    
    
    // MARK: - Initialization
    
    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    override func actionButtonTapped() {
        print("tappy")
        self.delegate.didTapGithubProfile(for: self.user)
    }
    
    private func configureItems() {
        // stackview config
        self.itemInfoViewOne.set(itemInfoType: .repos, withCount: self.user.publicRepos)
        self.itemInfoViewTwo.set(itemInfoType: .gists, withCount: self.user.publicGists)
        
        // button config
        self.actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
