//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/23/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

/**
* Represents a UIButton used throughout the application.
*/
class GFButton: UIButton {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Methods
    
    private func configure() {
        layer.cornerRadius     = 10
        titleLabel?.font       = UIFont.preferredFont(forTextStyle: .headline)
        
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        
        setTitle(title, for: .normal)
    }

}
