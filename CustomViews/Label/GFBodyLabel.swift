//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/24/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(aligned alignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = alignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    /**
    * Configures a GFBodyLabel.
    */
    private func configure() {
        textColor                          = .secondaryLabel
        font                               = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory  = true
        adjustsFontSizeToFitWidth          = true
        minimumScaleFactor                 = 0.75
        lineBreakMode                      = .byWordWrapping
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
