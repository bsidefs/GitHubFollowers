//
//  GFDataLoadingVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/30/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    
    // MARK: - Properties
    var containerView: UIView!
    
    
    // MARK: - Methods
    
    func presentLoadingView() {
        containerView = UIView(frame: self.view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25, animations: { self.containerView.alpha = 0.7 })
        
        let activityIndicator           = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String) {
        let emptyStateView   = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        
        view.addSubview(emptyStateView)
    }

}
