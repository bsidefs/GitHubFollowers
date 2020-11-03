//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/8/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(size: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    /**
    * Configures a GFBodyLabel.
    */
    private func configure() {
        self.textColor                  = .secondaryLabel
        self.adjustsFontSizeToFitWidth  = true
        self.minimumScaleFactor         = 0.90
        self.lineBreakMode              = .byTruncatingTail
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    

}
