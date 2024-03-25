//
//  ProfileView.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/25/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import UIKit

class ProfileView: BaseView {
    
    var image = UIImageView()
    
    var username = UILabel()
    
    var playListTitleContainer = UIView()
    var playListTitle = UILabel()
    
    override func setUpStyle() {
        super.setUpStyle()
        
        image.do {
            let uiImage = UIImage(named: "DummyProfile")
            $0.image = uiImage
        }
        
        username.do {
            $0.text = "dummy"
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
        
        playListTitle.do {
            $0.text = "저장된 플레이리스트"
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        addSubviews(image,
                    username, 
                    playListTitleContainer)
        playListTitleContainer.addSubviews(playListTitle)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        image.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(safeAreaLayoutGuide).offset(32)
        }
        
        username.snp.makeConstraints {
            $0.centerY.equalTo(image)
            $0.leading.equalTo(image.snp.trailing).offset(16)
        }
        
        playListTitleContainer.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        playListTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
}
