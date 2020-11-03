//
//  UIView+EXT.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 11/2/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     * Adds an  array of subviews to the view.
     */
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
    
    /**
     * Constrains a view to the edges of a superview.
     */
    func pinSelfToEdges(of superview: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
