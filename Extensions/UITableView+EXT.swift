//
//  UITableView+EXT.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 11/2/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
     * A quicker way to reload a tableview's data.
     */
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    /**
     * Removes unused tableview cells.
     */
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
