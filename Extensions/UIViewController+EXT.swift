//
//  UIViewController+EXT.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/24/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    // MARK: - Methods
    
    /**
    * Presents a GFAlert.
    */
    func presentGFAlertOnMainThread(title: String, body: String, actionTitle: String) {
        DispatchQueue.main.async {
            let alert                       = GFAlertVC(alertTitle: title, alertBody: body, actionTitle: actionTitle)
            
            alert.modalPresentationStyle    = .overFullScreen
            alert.modalTransitionStyle      = .crossDissolve
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC                        = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor  = .systemGreen
        
        self.present(safariVC, animated: true)
    }    
}
