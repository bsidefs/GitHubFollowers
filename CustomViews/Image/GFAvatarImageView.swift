//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/28/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    // MARK: - Properties
    
    let cache            = NetworkManager.shared.cache
    let placeholderImage = Image.placeholder

    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        layer.cornerRadius = 8
        clipsToBounds      = true
        image              = placeholderImage
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
