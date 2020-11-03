//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/5/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    // MARK: - Properties
    
    let messageLabel  = GFTitleLabel(aligned: .center, fontSize: 26)
    let logoImageView = UIImageView()

    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: UIScreen.main.bounds)
        self.messageLabel.text = message
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        backgroundColor = .systemBackground
        
        addSubviews(messageLabel, logoImageView)
        
        configureMessageLabel()
        configureLogoImageView()
    }
    
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 3
        messageLabel.textColor     = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? -80 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoImageView() {
        
        logoImageView.image = Image.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 80 : 40
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.1),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, constant: 1.1),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant),
        ])
    }
}
