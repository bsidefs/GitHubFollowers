//
//  GFAlertContainerView.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/30/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFAlertContainerView: UIView {

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
        backgroundColor    = .systemBackground
        layer.borderColor  = UIColor.white.cgColor
        layer.borderWidth  = 1
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
