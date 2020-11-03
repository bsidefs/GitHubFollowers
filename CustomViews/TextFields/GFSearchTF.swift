//
//  GFSearchTF.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/23/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFSearchTF: UITextField {
    
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
        
        layer.cornerRadius          = 8
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        
        autocorrectionType          = .no
        autocapitalizationType      = .none
        
        clearButtonMode             = .whileEditing
        
        placeholder                 = "Enter a username"
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
