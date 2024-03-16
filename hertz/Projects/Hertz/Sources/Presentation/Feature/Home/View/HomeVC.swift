//
//  HomeVC.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/12/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class HomeVC: BaseVC, UIScrollViewDelegate, HomeDelegate {
    
    override var isNavigationBarHidden: Bool { true }
    
    private var scrollView: UIScrollView!
    
    private var stack: UIStackView!
    
    private var gnbBar: UIView!
    
    private let gnbHeight: CGFloat = 48
    
    private var logo: UIImageView!
    
    private var showShadow = false
    
    private var banner: UIHostingController<BannerView>!
    
    private var titleContainer: UIView!
    
    private var title1: UILabel!
    
    private var forYouVC = ForYouVC()
    
    private var categoryContainer: UIStackView!
    
    private var musicContainer: UIStackView!
    
    private var musicCells: [MusicCell] = []
    
    private var player: UIView!
    
    private var playingImage: UIImageView!
    
    private var playingTitle: UILabel!
    
    private var playingAuthor: UILabel!
    
    private var playButton: UIButton!
    
    private let playerHeight: CGFloat = 90
    
    private let homePresenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        homePresenter.setDelegate(delegate: self)
    }
    
    func setupScroll() {
        scrollView.delegate = self
        scrollView.addObserver(self, forKeyPath: "contentOffset", options:. new, context: nil)
    }
    
    override func setUpStyle() {
        self.view.backgroundColor = .gray800
        scrollView = .init().then {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
        
        stack = .init().then {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 0
        }
        
        gnbBar = .init().then {
            $0.layer.zPosition = 2
            $0.backgroundColor = .gray800
            $0.layer.shadowPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: $0.layer.cornerRadius).cgPath
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.0
            $0.layer.shadowOffset = .init(width: 0, height: 4)
            $0.layer.shadowRadius = 12
        }
        
        logo = .init().then {
            let uiImage = UIImage(named: "Logo")
            $0.image = uiImage
        }
        
        banner = .init(rootView: BannerView()).then {
            $0.view.backgroundColor = .gray800
        }
        
        titleContainer = .init().then { _ in
            
        }
        
        title1 = .init().then {
            $0.text = "당신을 위한 주파수"
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = .white
        }
        
        categoryContainer = .init().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 28
        }
        
        musicContainer = .init().then {
            $0.axis = .vertical
            $0.spacing = 0
            $0.alignment = .leading
            $0.distribution = .fill
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        player = .init().then {
            $0.layer.zPosition = 3
            $0.backgroundColor = .gray800
            
            $0.layer.shadowPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: $0.layer.cornerRadius).cgPath
            //        v.roundCorners(cornerRadius: 36, byRoundingCorners: [.topLeft, .topRight])
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.15
            $0.layer.shadowOffset = .init(width: 0, height: 4)
            $0.layer.shadowRadius = 12
        }
        
        playingImage = .init().then {
            let uiImage = UIImage(named: "Logo")
            $0.image = uiImage
            $0.layer.cornerRadius = 18
        }
        
        playingTitle = .init().then {
            $0.text = "모든 소원이 이루어지는 주파수"
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .white
        }
        
        playingAuthor = .init().then {
            $0.text = "Jazz Hot Cafe"
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .gray500
        }
        
        playButton = .init().then {
            let uiImage = UIImage(named: "Play")
            $0.setImage(uiImage, for: .normal)
        }
    }
    
    override func configure() {
        
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(stack)
        
        self.view.addSubview(gnbBar)
        self.view.addSubview(player)
        self.player.addSubview(playingImage)
        self.player.addSubview(playingTitle)
        self.player.addSubview(playingAuthor)
        self.player.addSubview(playButton)
        
        self.gnbBar.addSubview(logo)
        
        self.stack.addArrangedSubview(banner.view)
        addChild(banner)
        banner.didMove(toParent: self)
        
        self.stack.addArrangedSubview(titleContainer)
        
        self.titleContainer.addSubview(title1)
        
        self.stack.addArrangedSubview(forYouVC.view)
        addChild(forYouVC)
        forYouVC.didMove(toParent: self)
        
        self.stack.addArrangedSubview(categoryContainer)
        categoryContainer.addArrangedSubview(createCategoryButton(title: "최근 들은", isSelected: true))
        categoryContainer.addArrangedSubview(createCategoryButton(title: "인기 있는"))
        categoryContainer.addArrangedSubview(createCategoryButton(title: "찜"))
        
        self.stack.addArrangedSubview(musicContainer)
    }
    
    override func setUpLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.layoutMarginsGuide)
            make.leading.trailing.equalTo(view)
        }
        
        stack.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        gnbBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(gnbHeight)
        }
        
        logo.snp.makeConstraints { make in
            make.leading.equalTo(gnbBar).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        banner.view.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide).offset(48)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(72)
        }
        
        titleContainer.snp.makeConstraints { make in
            make.top.equalTo(banner.view.snp.bottom).offset(24)
            make.leading.trailing.equalTo(scrollView)
            make.height.equalTo(48)
        }
        
        title1.snp.makeConstraints { make in
            make.leading.equalTo(titleContainer).offset(20)
            make.centerY.equalTo(titleContainer)
        }
        
        forYouVC.view.snp.makeConstraints { make in
            make.height.equalTo(202)
            make.top.equalTo(titleContainer.snp.bottom)
            make.bottom.equalTo(categoryContainer.snp.top).offset(-24)
            make.leading.trailing.equalTo(view)
        }
        
        categoryContainer.snp.makeConstraints { make in
            make.top.equalTo(forYouVC.view.snp.bottom)
            make.leading.equalTo(stack).offset(28)
            make.height.equalTo(48)
        }
        
        musicContainer.snp.makeConstraints { make in
            make.top.equalTo(categoryContainer.snp.bottom)
            make.leading.equalTo(stack).offset(24)
            make.trailing.equalTo(stack).offset(-24)
        }
        
        player.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(musicContainer)
            make.height.equalTo(playerHeight)
        }
        
        playingImage.snp.makeConstraints { make in
            make.top.equalTo(player).offset(18)
            make.leading.equalTo(view).offset(18)
        }
        
        playingTitle.snp.makeConstraints { make in
            make.top.equalTo(player).offset(22)
            make.leading.equalTo(playingImage.snp.trailing).offset(16)
        }
        
        playingAuthor.snp.makeConstraints { make in
            make.top.equalTo(playingTitle.snp.bottom).offset(4)
            make.leading.equalTo(playingImage.snp.trailing).offset(16)
        }
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(player).offset(23)
            make.trailing.equalTo(view).offset(-18)
        }
    }
    
    func make(musics: [Music]) {
        musicCells = []
        musicContainer.arrangedSubviews.forEach { musicCell in
            musicContainer.removeArrangedSubview(musicCell)
            musicCell.removeFromSuperview()
        }
        Array(musics.enumerated()).forEach { idx, m in
            let image = UIImageView().then {
                let uiImage = UIImage(named: m.image)
                $0.image = uiImage
                $0.layer.cornerRadius = 16
            }
            let v = UIButton().then {
                $0.addTarget(self, action: #selector(clickMusic(_:)), for: .touchUpInside)
                $0.tag = idx
            }
            let title = UILabel().then {
                $0.text = m.music
                $0.textColor = .white
                $0.numberOfLines = 0
                $0.sizeToFit()
                $0.font = .systemFont(ofSize: 16, weight: .medium)
            }
            let author = UILabel().then {
                $0.text = m.author
                $0.textColor = .gray500
                $0.numberOfLines = 0
                $0.sizeToFit()
                $0.font = .systemFont(ofSize: 14, weight: .regular)
            }
            let music = MusicCell(container: v, image: image, music: title, author: author)
            music.do {
                print($0)
                $0.container.addSubview($0.image)
                $0.container.addSubview($0.music)
                $0.container.addSubview($0.author)
                musicContainer.addArrangedSubview($0.container)
                musicCells.append($0)
            }
        }
        
        musicCells.forEach { m in
            m.container.snp.makeConstraints { make in
                make.height.greaterThanOrEqualTo(72)
                make.leading.trailing.equalTo(musicContainer)
            }
            m.image.snp.makeConstraints { make in
                make.top.bottom.equalTo(m.container)
                make.leading.equalTo(m.container)
                make.width.height.equalTo(54)
            }
            m.music.snp.makeConstraints { make in
                make.leading.equalTo(m.image.snp.trailing).offset(10)
                make.trailing.equalTo(m.container)
                make.top.equalTo(m.image).offset(4)
            }
            m.author.snp.makeConstraints { make in
                make.leading.equalTo(m.image.snp.trailing).offset(10)
                make.top.equalTo(m.music.snp.bottom).offset(2)
                make.trailing.equalTo(m.container)
            }
        }
    }
    
    func createCategoryButton(title: String, isSelected: Bool = false) -> UIButton {
        let b = UIButton()
        b.setTitle(title, for: .normal)
        let titleColor: UIColor = isSelected ? .white : .gray500
        b.setTitleColor(titleColor, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return b
    }
    
    func showGnbShadow() {
        gnbBar.layer.shadowOpacity = 0.16
    }
    
    func hideGnbShadow() {
        gnbBar.layer.shadowOpacity = 0.0
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            let y = scrollView.contentOffset.y
            if y > gnbHeight && !showShadow {
                showGnbShadow()
                showShadow = true
            } else if y <= gnbHeight && showShadow {
                hideGnbShadow()
                showShadow = false
            }
        }
    }
    
    @objc func clickMusic(_ sender: UIButton) {
        print("clicked")
        homePresenter.clickMusic(tag: sender.tag)
    }
    
    func displayMusics(musics: [Music]) {
        make(musics: musics)
    }
    
    func navigateDetail(music: Music) {
        let detailVC = DetailVC()
        detailVC.music = music
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
}
