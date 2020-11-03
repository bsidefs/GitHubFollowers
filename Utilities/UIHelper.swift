//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/31/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

struct UIHelper {
    
    /**
     * Creates a 3x3 Flow Layout for the FollowerListVC's CollectionView.
     */
    static func create3xFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        
        let padding: CGFloat            = 12
        let minimumCellSpacing: CGFloat = 10
        
        let availableWidth              = width - ( (padding * 2) + (minimumCellSpacing * 2))
        let itemWidth                   = (availableWidth / 3)
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
