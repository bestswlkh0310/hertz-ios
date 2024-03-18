import UIKit
import SwiftUI

class HomeView: BaseView {
    
    private var delegate: HomeDelegate?
    
    private var scrollView = UIScrollView()
    
    private var stack = UIStackView()
    
    private var gnbBar = UIView()
    
    private let gnbHeight: CGFloat = 48
    
    private var logo = UIImageView()
    
    private var showShadow = false
    
    private var banner = UIHostingController<BannerView>(rootView: BannerView())
    
    private var titleContainer = UIView()
    
    private var title1 = UILabel()
    
    private var forYouVC = ForYouViewController()
    
    private var categoryContainer = UIStackView()
    
    private var musicViewController = MusicViewController()
    
    private var player = UIView()
    
    private var playingImage = UIImageView()
    
    private var playingTitle = UILabel()
    
    private var playingAuthor = UILabel()
    
    private var playButton = UIButton()
    
    private let playerHeight: CGFloat = 90
    
    override func setUpStyle() {
        super.setUpStyle()
        self.backgroundColor = .gray800
        scrollView = .init().then {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
        
        stack.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 0
        }
        
        gnbBar.do {
            $0.layer.zPosition = 2
            $0.backgroundColor = .gray800
            $0.layer.shadowPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: $0.layer.cornerRadius).cgPath
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.0
            $0.layer.shadowOffset = .init(width: 0, height: 4)
            $0.layer.shadowRadius = 12
        }
        
        logo.do {
            let uiImage = UIImage(named: "Logo")
            $0.image = uiImage
        }
        
        banner = .init(rootView: BannerView()).then {
            $0.view.backgroundColor = .gray800
        }
        
        titleContainer.do { _ in
            
        }
        
        title1.do {
            $0.text = "당신을 위한 주파수"
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = .white
        }
        
        categoryContainer.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 28
        }
        
        musicViewController.do { _ in
            
        }
        
        player.do {
            $0.layer.zPosition = 3
            $0.backgroundColor = .gray800
            
            $0.layer.shadowPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: $0.layer.cornerRadius).cgPath
            //        v.roundCorners(cornerRadius: 36, byRoundingCorners: [.topLeft, .topRight])
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.15
            $0.layer.shadowOffset = .init(width: 0, height: 4)
            $0.layer.shadowRadius = 12
        }
        
        playingImage.do {
            let uiImage = UIImage(named: "Logo")
            $0.image = uiImage
            $0.layer.cornerRadius = 18
        }
        
        playingTitle.do {
            $0.text = "모든 소원이 이루어지는 주파수"
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .white
        }
        
        playingAuthor.do {
            $0.text = "Jazz Hot Cafe"
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .gray500
        }
        
        playButton.do {
            let uiImage = UIImage(named: "Play")
            $0.setImage(uiImage, for: .normal)
        }
    }
    
    override func configure() {
        super.configure()
        
        self.addSubview(scrollView)
        self.scrollView.addSubview(stack)
        
        self.addSubview(gnbBar)
        self.addSubview(player)
        self.player.addSubview(playingImage)
        self.player.addSubview(playingTitle)
        self.player.addSubview(playingAuthor)
        self.player.addSubview(playButton)
        
        self.gnbBar.addSubview(logo)
        
        self.stack.addArrangedSubview(banner.view)
        self.stack.addArrangedSubview(titleContainer)
        
        self.titleContainer.addSubview(title1)
        
        self.stack.addArrangedSubview(forYouVC.view)
        self.stack.addArrangedSubview(categoryContainer)
        
        categoryContainer.addArrangedSubview(createCategoryButton(title: "최근 들은", isSelected: true))
        categoryContainer.addArrangedSubview(createCategoryButton(title: "인기 있는"))
        categoryContainer.addArrangedSubview(createCategoryButton(title: "찜"))
        
        self.stack.addArrangedSubview(musicViewController.view)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(layoutMarginsGuide)
            make.leading.trailing.equalTo(self)
        }
        
        stack.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        gnbBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(gnbHeight)
        }
        
        logo.snp.makeConstraints { make in
            make.leading.equalTo(gnbBar).offset(20)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        banner.view.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide).offset(48)
            make.leading.trailing.equalTo(self)
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
            make.leading.trailing.equalTo(self)
        }
        
        categoryContainer.snp.makeConstraints { make in
            make.top.equalTo(forYouVC.view.snp.bottom)
            make.leading.equalTo(stack).offset(28)
            make.height.equalTo(48)
        }
        
        musicViewController.view.snp.makeConstraints { make in
            make.top.equalTo(categoryContainer.snp.bottom)
            make.leading.equalTo(stack).offset(24)
            make.trailing.equalTo(stack).offset(-24)
        }
        
        player.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(musicViewController.view)
            make.height.equalTo(playerHeight)
        }
        
        playingImage.snp.makeConstraints { make in
            make.top.equalTo(player).offset(18)
            make.leading.equalTo(self).offset(18)
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
            make.trailing.equalTo(self).offset(-18)
        }
    }
    
    func configureDelegate(_ delegate: HomeDelegate) {
        self.delegate = delegate
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
    
    func handleScrollHeight() {
        let y = scrollView.contentOffset.y
        if y > gnbHeight && !showShadow {
            showGnbShadow()
            showShadow = true
        } else if y <= gnbHeight && showShadow {
            hideGnbShadow()
            showShadow = false
        }
    }
    
    func configureViewControllers() {
        if let delegate = delegate {
            delegate.useViewController {
                $0.addChild(banner)
                banner.didMove(toParent: $0)
                
                $0.addChild(forYouVC)
                forYouVC.didMove(toParent: $0)
                
                $0.addChild(musicViewController)
                musicViewController.didMove(toParent: $0)
            }
        } else {
            print("\(#file) delegate is nil")
        }
    }
    
    func configureScrollView(observer: NSObject, delegate: UIScrollViewDelegate) {
        scrollView.addObserver(observer, forKeyPath: "contentOffset", options:. new, context: nil)
        scrollView.delegate = delegate
    }
    
    func removeScrollViewObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        scrollView.removeObserver(observer, forKeyPath: keyPath)
    }
    
    func updateMusics(musics: [Music]) {
        musicViewController.updateMusics(musics: musics)
    }
}
