//
//  PlayListViewController.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/25/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//


import UIKit

class PlaylistViewController: BaseViewController {
    var playlists: [Playlist] = []
    
    var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    let cellIdentifier = "PlaylistCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        layout.do {
            $0.scrollDirection = .vertical
        }
        
        collectionView = .init(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .init(0, alpha: 0)
            $0.showsVerticalScrollIndicator = false
            $0.register(PlaylistViewCell.self,  forCellWithReuseIdentifier: cellIdentifier)
        }
        
        view.addSubviews(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PlaylistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PlaylistViewCell
        cell.setPlaylist(playlist: playlists[indexPath.item])
        return cell
    }
}

extension PlaylistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 72)
    }
}
