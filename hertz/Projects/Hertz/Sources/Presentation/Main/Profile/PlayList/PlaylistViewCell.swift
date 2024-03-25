//
//  PlayListViewCell.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/25/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import UIKit

class PlaylistViewCell: BaseCollectionViewCell {
    
    // MARK: UI
    var image = UIImageView()
    var title = UILabel()
    var author = UILabel()
    
    // MARK: Models
    var music: Music?
    
    override func setUpStyle() {
        super.setUpStyle()
        image.do {
            _ = $0
        }
        
        title.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .white
        }
        
        author.do {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .gray500
        }
    }
    
    override func configure() {
        super.configure()
        addSubviews(image, 
                    title,
                    author)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        image.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(image.snp.trailing).offset(8)
        }
        
        author.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(2)
            $0.leading.equalTo(image.snp.trailing).offset(8)
        }
    }
    
    func setPlaylist(playlist: Playlist) {
        title.text = playlist.title
        author.text = playlist.author
        let uiImage = UIImage(named: playlist.image)
        image.image = uiImage
    }
    
}
