//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/10/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    // MARK: - Properties
    weak var delegate: GFFollowerItemVCDelegate!
    
    
    // MARK: - Initialization
    
    init(user: User, delegate: GFFollowerItemVCDelegate) {
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
        self.delegate.didTapGetFollowers(for: self.user)
    }
    
    private func configureItems() {
        // stackview config
        self.itemInfoViewOne.set(itemInfoType: .followers, withCount: self.user.followers)
        self.itemInfoViewTwo.set(itemInfoType: .following, withCount: self.user.following)
        
        // button config
        self.actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
