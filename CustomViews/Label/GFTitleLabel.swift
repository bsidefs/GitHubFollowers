//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/24/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(aligned alignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = alignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    /**
    * Configures a GFTitleLabel.
    */
    private func configure() {
        self.textColor                  = .label
        self.adjustsFontSizeToFitWidth  = true
        self.minimumScaleFactor         = 0.9
        self.lineBreakMode              = .byTruncatingTail
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
