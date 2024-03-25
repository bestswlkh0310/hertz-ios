//
//  ProfileViewController.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/25/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    var profileView = ProfileView()
    
    override var isNavigationBarHidden: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "프로필"
        view = profileView
    }
    
    func configureChildVC() {
        addChild(profileView.playlistViewController)
        profileView.playlistViewController.didMove(toParent: self)
    }
    
}
