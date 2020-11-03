//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/10/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    // MARK: - Properties
    
    let symbolImageView     = UIImageView()
    let titleLabel          = GFTitleLabel(aligned: .left, fontSize: 16)
    let countLabel          = GFTitleLabel(aligned: .center, fontSize: 16)
    
    
    // MARK: - Initialiation
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods

    func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
            case .repos:
                symbolImageView.image  = SFSymbol.repos
                titleLabel.text        = "Public Repos"
                
            case .gists:
                symbolImageView.image  = SFSymbol.gists
                titleLabel.text        = "Public Gists"
                
            case .followers:
                symbolImageView.image  = SFSymbol.followers
                titleLabel.text        = "Followers"
                
            case .following:
                symbolImageView.image  = SFSymbol.following
                titleLabel.text        = "Following"
        }
        
        countLabel.text                = String(count)
    }
}
