//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/6/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for user: User)
}

class UserInfoVC: GFDataLoadingVC {
    
    // MARK: - Properties
    
    var username        : String!
    var user            : User!
    
    weak var delegate   : UserInfoVCDelegate!
    
    // component views
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(aligned: .center)
    
    var scrollView  : UIScrollView!
    var contentView : UIView!
    
    var itemViews   = [UIView]()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        layoutUI()
        
        getUserInfo(for: self.username)
    }
    
    
    // MARK: - Methods
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    
    /**
     * Used for modal presentations.
     */
    func configureNavigationBar() {
        // if modal (for accessibility)
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissVC))
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureScrollView() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints    = false
        scrollView.pinSelfToEdges(of: view)
        
        contentView.translatesAutoresizingMaskIntoConstraints   = false
        contentView.pinSelfToEdges(of: scrollView)
        
        // content views still need a height/width
        if DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed {
            contentView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        }
        else {
            contentView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        }
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    
    func layoutUI() {
        itemViews = [headerView,itemViewOne,itemViewTwo, dateLabel]
        
        let padding: CGFloat        = 20
        
        let cardHeight: CGFloat     = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 130 : 140
        let cardPadding: CGFloat    = 30
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: cardHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: cardPadding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: cardHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    func addChildVC(_ childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        
        childVC.view.frame = containerView.bounds
        
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
    
    
    func getUserInfo(for username: String) {
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    self.user = user
                    DispatchQueue.main.async {
                        self.configureUIElements(with: user)
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something Went Wrong :(", body: error.rawValue, actionTitle: "Okay")
            }
        })
    }
    
    
    func configureUIElements(with user: User) {
        addChildVC(GFUserInfoHeaderVC(user: self.user), to: self.headerView)
        
        let repoItemVC          = GFRepoItemVC(user: self.user, delegate: self)
        let followerItemVC      = GFFollowerItemVC(user: self.user, delegate: self)
        
        addChildVC(repoItemVC, to: self.itemViewOne)
        addChildVC(followerItemVC, to: self.itemViewTwo)
        
        dateLabel.text          = "GitHub member since \(self.user.createdAt.convertToMonthYearFormat())"
    }
    
}

// MARK: - Extensions

extension UserInfoVC: GFRepoItemVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            self.presentGFAlertOnMainThread(title: "Something Bad Happened :(", body: "The URL attached to this user is invalid.", actionTitle: "Okay")
            return
        }
        
        self.presentSafariVC(with: url)
    }
}


extension UserInfoVC: GFFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            self.presentGFAlertOnMainThread(title: "No Followers", body: "This user has no followers. What a shame 😔", actionTitle: "So sad")
            return
        }
    
        delegate.didRequestFollowers(for: user)
        //dismissVC()
        self.navigationController?.popViewController(animated: true)
    }
}
