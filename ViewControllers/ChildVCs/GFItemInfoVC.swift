//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/10/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    // MARK: - Properties
    
    let stackView           = UIStackView()
    let itemInfoViewOne     = GFItemInfoView()
    let itemInfoViewTwo     = GFItemInfoView()
    let actionButton        = GFButton()
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        configureActionButton()
        layoutUI()
    }
    
    // MARK: - Initialization
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(self.actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {
        // implementation done by the subclass
    }
    
    private func layoutUI() {
        view.addSubviews(stackView,actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat        = 20
        let buttonHeight: CGFloat   = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 38 : 44
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}
