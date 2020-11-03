//
//  GFAlertVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 8/24/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
    
    // MARK: - Properties
    
    let containerView    = GFAlertContainerView(frame: .zero)
    let titleLabel       = GFTitleLabel(aligned: .center, fontSize: 20)
    let bodyLabel        = GFBodyLabel(aligned: .center)
    let actionButton     = GFButton(backgroundColor: .systemPink, title: "Okay")
    let padding: CGFloat = 20
    
    var alertTitle  :  String!
    var alertBody   :  String!
    var actionTitle :  String!
    
    
    // MARK: - Initialization
    
    init(alertTitle: String, alertBody: String, actionTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = alertTitle
        self.alertBody      = alertBody
        self.actionTitle    = actionTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, titleLabel, actionButton, bodyLabel)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    
    // MARK: - Methods
    
    func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureTitleLabel() {
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureBodyLabel() {
        bodyLabel.text          = alertBody
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    /**
    * Configures this VC's action button.
    */
    func configureActionButton() {
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(self.dismissGFAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func dismissGFAlert() {
        self.dismiss(animated: true)
    }
}
