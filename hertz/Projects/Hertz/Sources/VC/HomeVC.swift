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

class HomeVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Foundation
    private var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.backgroundColor = .clear
        s.showsVerticalScrollIndicator = false
        return s
    }()
    
    private var stack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .leading
        s.spacing = 0
        return s
    }()
    
    // MARK: - GNB
    private var gnbBar: UIView = {
        let v = UIView()
        v.layer.zPosition = 2
        v.backgroundColor = .gray800
        
        v.layer.shadowPath = UIBezierPath(roundedRect: v.bounds,
                                          cornerRadius: v.layer.cornerRadius).cgPath
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.0
        v.layer.shadowOffset = .init(width: 0, height: 4)
        v.layer.shadowRadius = 12
        
        
        return v
    }()
    
    private let gnbHeight: CGFloat = 48
    
    private var logo: UIImageView = {
        if let image = UIImage(named: "Logo") {
            let imageView = UIImageView(image: image)
            return imageView
        } else {
            fatalError("Logo image is missing")
        }
    }()
    
    // MARK: properties
    private var showShadow = false
    
    // MARK: - Banner
    private var banner: UIHostingController = {
        let v = UIHostingController(rootView: BannerView())
        v.view.backgroundColor = .gray800
        return v
    }()
    
    // MARK: - Title
    private var titleContainer: UIView = {
        let v = UIView()
        return v
    }()
    
    private var title1: UILabel = {
        let l = UILabel()
        l.text = "당신을 위한 주파수"
        l.font = .systemFont(ofSize: 20, weight: .semibold)
        l.textColor = .white
        return l
    }()
    
    // MARK: - ForYou
    private var forYouVC = ForYouVC()
    
    // MARK: - Music
    private var categoryContainer: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.alignment = .center
        s.distribution = .fill
        s.spacing = 28
        return s
    }()
    
    private var musicContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: properties
    private var musics: [MusicModel] = MusicModel.stubs
    private var musicCells: [MusicCell] = []
    
    
    // MARK: - player
    private var player: UIView = {
        let v = UIView()
        v.layer.zPosition = 3
        v.backgroundColor = .gray800
        
        v.layer.shadowPath = UIBezierPath(roundedRect: v.bounds,
                                          cornerRadius: v.layer.cornerRadius).cgPath
//        v.roundCorners(cornerRadius: 36, byRoundingCorners: [.topLeft, .topRight])
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.15
        v.layer.shadowOffset = .init(width: 0, height: 4)
        v.layer.shadowRadius = 12
        return v
    }()
    
    private var playingImage: UIImageView = {
        let image = UIImageView()
        let uiImage = UIImage(named: "Logo")
        image.image = uiImage
        image.layer.cornerRadius = 18
        return image
    }()
    
    private var playingTitle: UILabel = {
        let l = UILabel()
        l.text = "모든 소원이 이루어지는 주파수"
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.textColor = .white
        return l
    }()
    
    private var playingAuthor: UILabel = {
        let l = UILabel()
        l.text = "Jazz Hot Cafe"
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .gray500
        return l
    }()
    
    private var playButton: UIButton = {
        let uiImage = UIImage(named: "Play")
        let button = UIButton()
        button.setImage(uiImage, for: .normal)
        return button
    }()
    
    // MARK: properties
    private let playerHeight: CGFloat = 90
    
    
    func createCategoryButton(title: String, isSelected: Bool = false) -> UIButton {
        let b = UIButton()
        b.setTitle(title, for: .normal)
        let titleColor: UIColor = isSelected ? .white : .gray500
        b.setTitleColor(titleColor, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return b
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        setUpStyle()
        setUpLayout()
    }
    
    func setupScroll() {
        scrollView.delegate = self
        scrollView.addObserver(self, forKeyPath: "contentOffset", options:. new, context: nil)
    }
    
    func setUpStyle() {
        self.view.backgroundColor = .gray800
    }
    
    func setUpLayout() {
        
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
        musics.forEach { m in
            let image: UIImageView = {
                let uiImage = UIImage(named: m.image)
                let image = UIImageView()
                image.image = uiImage
                image.layer.cornerRadius = 16
                return image
            }()
            let v: UIButton = {
                let v = UIButton()
                v.addTarget(self, action: #selector(clickMusic), for: .touchUpInside)
                return v
            }()
            let title: UILabel = {
                let title = UILabel()
                title.text = m.title
                title.textColor = .white
                title.font = .systemFont(ofSize: 16, weight: .medium)
                return title
            }()
            let author: UILabel = {
                let author = UILabel()
                author.text = m.author
                author.textColor = .gray500
                author.font = .systemFont(ofSize: 14, weight: .regular)
                return author
            }()
            let m = MusicCell(container: v, image: image, title: title, author: author)
            m.container.addSubview(m.image)
            m.container.addSubview(m.title)
            m.container.addSubview(m.author)
            musicContainer.addArrangedSubview(m.container)
            musicCells.append(m)
        }
        
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
            make.leading.trailing.equalTo(gnbBar)
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
            make.leading.trailing.equalTo(stack)
            make.height.equalTo(musicCells.count * 72)
        }
        
        musicCells.forEach { m in
            m.container.snp.makeConstraints { make in
                make.height.equalTo(72)
                make.leading.trailing.equalTo(musicContainer)
            }
            m.image.snp.makeConstraints { make in
                make.top.bottom.equalTo(m.container)
                make.leading.equalTo(m.container).offset(24)
                make.width.height.equalTo(54)
            }
            m.title.snp.makeConstraints { make in
                make.leading.equalTo(m.image.snp.trailing).offset(10)
                make.top.equalTo(m.image).offset(4)
            }
            m.author.snp.makeConstraints { make in
                make.leading.equalTo(m.image.snp.trailing).offset(10)
                make.top.equalTo(m.title.snp.bottom).offset(2)
            }
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
    
    @objc func clickMusic() {
        print("Hello!")
    }
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
}
