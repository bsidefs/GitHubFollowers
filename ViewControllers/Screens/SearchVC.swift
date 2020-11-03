//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/23/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    
    let logo:       UIImageView = UIImageView()
    let usernameTF: GFSearchTF  = GFSearchTF()
    let cta:        GFButton    = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        return !self.usernameTF.text!.isEmpty
    }
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubviews(logo, usernameTF, cta)
        
        configureLogo()
        configureUsernameTF()
        configureCTA()
        createKeyboardDismissTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTF.text = ""
    }
    
    
    // MARK: - Methods
    
    /**
     * Instantiates an instance of the FollowersListVC and sets the username to search for.
     *
     * Called when the "Get Followers" GFButton is tapped.
     */
    @objc func pushFollowersListVC() {
        guard self.isUsernameEntered else {
            self.presentGFAlertOnMainThread(title: "Empty Username", body: "We need a username to search for first 😎", actionTitle: "Okay")
            return
        }
        
        let followersListVC = FollowersListVC(username: self.usernameTF.text!)
        self.navigationController?.pushViewController(followersListVC, animated: true)
        
        usernameTF.resignFirstResponder()
    }
    
    
    func configureLogo() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        logo.image = Image.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 200),
            logo.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    /**
    * Configures this VC's main "username" Text Field.
    */
    func configureUsernameTF() {
        NSLayoutConstraint.activate([
            usernameTF.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            usernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTF.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.usernameTF.delegate = self
    }
    
    
    func configureCTA() {
        NSLayoutConstraint.activate([
            cta.topAnchor.constraint(equalTo: usernameTF.bottomAnchor, constant: 20),
            cta.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            cta.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            cta.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        cta.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
    }
    
    
    func createKeyboardDismissTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
}


// MARK: - Extension

extension SearchVC: UITextFieldDelegate {
    
    /**
     * Called when the usernameTF becomes the First Responder.
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    /**
    * Called when the usernameTF resigns its First Responder status.
    */
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
}
