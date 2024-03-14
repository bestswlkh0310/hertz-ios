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

class HomeVC: UIViewController {
    
    private var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.backgroundColor = .clear
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private var stack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.alignment = .leading
        s.spacing = 0
        return s
    }()
    
    private var gnbBar: UIView = {
        let v = UIView()
        v.layer.zPosition = 2
        v.backgroundColor = .gray800
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var logo: UIImageView = {
        if let image = UIImage(named: "Logo") {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        } else {
            fatalError("Logo image is missing")
        }
    }()
    
    private var banner: UIHostingController = {
        let v = UIHostingController(rootView: BannerView())
        v.view.translatesAutoresizingMaskIntoConstraints = false
        v.view.backgroundColor = .gray800
        return v
    }()
    
    private var titleContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var title1: UILabel = {
        let l = UILabel()
        l.text = "당신을 위한 주파수"
        l.font = .systemFont(ofSize: 20, weight: .semibold)
        l.textColor = .white
        return l
    }()
    
    private var forYouVC = ForYouVC()
    
    private var categoryContainer: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.alignment = .center
        s.distribution = .fill
        s.spacing = 28
        s.translatesAutoresizingMaskIntoConstraints = false
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
    
    private var musics: [MusicModel] = MusicModel.stubs
    private var musicCells: [MusicCell] = []
    
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
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(stack)
        
        self.view.addSubview(gnbBar)
        
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
                image.translatesAutoresizingMaskIntoConstraints = false
                image.layer.cornerRadius = 16
                return image
            }()
            let v: UIView = {
                let v = UIView()
                v.translatesAutoresizingMaskIntoConstraints = false
                return v
            }()
            let title: UILabel = {
                let title = UILabel()
                title.translatesAutoresizingMaskIntoConstraints = false
                title.text = m.title
                title.textColor = .white
                title.font = .systemFont(ofSize: 16, weight: .medium)
                return title
            }()
            let author: UILabel = {
                let author = UILabel()
                author.translatesAutoresizingMaskIntoConstraints = false
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
        setUpStyle()
        setUpLayout()
    }
    
    func setUpStyle() {
        self.view.backgroundColor = .gray800
    }
    
    func setUpLayout() {
        
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
            make.height.equalTo(48)
        }
        
        logo.snp.makeConstraints { make in
            make.leading.equalTo(gnbBar).offset(20)
            make.top.equalTo(gnbBar)
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
            make.leading.trailing.equalTo(view)
        }
        
        categoryContainer.snp.makeConstraints { make in
            make.top.equalTo(forYouVC.view.snp.bottom).offset(16)
            make.leading.equalTo(stack).offset(28)
            make.height.equalTo(48)
        }
        
        musicContainer.snp.makeConstraints { make in
            make.top.equalTo(categoryContainer.snp.bottom)
            make.leading.equalTo(stack)
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
    }
}
