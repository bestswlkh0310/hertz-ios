import UIKit
import SwiftUI

class HomeView: BaseView {
    
    var delegate: HomeDelegate?
    
    var scrollView = UIScrollView()
    
    var stack = UIStackView()
    
    var gnbBar = UIView()
    
    let gnbHeight: CGFloat = 48
    
    var logo = UIImageView()
    
    var banner = UIHostingController<BannerView>(rootView: BannerView())
    
    var titleContainer = UIView()
    
    var title1 = UILabel()
    
    var forYouVC = ForYouViewController()
    
    var categoryContainer = UIStackView()
    
    var categoryCell1 = CategoryCell()
    var categoryCell2 = CategoryCell()
    var categoryCell3 = CategoryCell()
    
    var musicViewController = MusicViewController()
    
    var player = UIView()
    
    var playingImage = UIImageView()
    
    var playingTitle = UILabel()
    
    var playingAuthor = UILabel()
    
    var playButton = UIButton()
    
    let playerHeight: CGFloat = 90
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        musicViewController.onClick = { idx in
            self.delegate?.clickMusic(tag: idx)
        }
    }
    
    override func setUpStyle() {
        super.setUpStyle()
        self.backgroundColor = .gray800
        scrollView.do {
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
        
        categoryCell1.do {
            $0.isSelected = true
            $0.button.setTitle("최근 들은", for: .normal)
        }
        
        categoryCell2.do {
            $0.button.setTitle("인기 있는", for: .normal)
        }
        
        categoryCell3.do {
            $0.button.setTitle("찜", for: .normal)
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
    
    override func configureUI() {
        super.configureUI()
        
        addSubview(scrollView)
        scrollView.addSubview(stack)
        
        bringSubviewToFront(gnbBar)
        bringSubviewToFront(player)
        addSubviews(gnbBar,
                    player)
        
        player.addSubviews(playingImage,
                    playingTitle,
                    playingAuthor,
                    playButton)
        
        gnbBar.addSubview(logo)
        
        stack.addArrangedSubviews(banner.view,
                                  titleContainer)
        
        titleContainer.addSubview(title1)
        
        stack.addArrangedSubviews(forYouVC.view,
                                  categoryContainer)
        
        
        categoryContainer.addArrangedSubviews(categoryCell1,
                                              categoryCell2,
                                              categoryCell3)
        
        stack.addArrangedSubview(musicViewController.view)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        stack.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        gnbBar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stack)
            make.height.equalTo(gnbHeight)
        }
        
        logo.snp.makeConstraints { make in
            make.leading.equalTo(gnbBar).offset(20)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        banner.view.snp.makeConstraints { make in
            make.top.equalTo(48)
            make.leading.trailing.equalTo(stack)
            make.height.equalTo(72)
        }
        
        titleContainer.snp.makeConstraints { make in
            make.top.equalTo(banner.view.snp.bottom).offset(24)
            make.leading.trailing.equalTo(stack)
            make.height.equalTo(48)
        }
        
        title1.snp.makeConstraints { make in
            make.leading.equalTo(titleContainer).offset(20)
            make.centerY.equalTo(titleContainer)
        }
        
        forYouVC.view.snp.makeConstraints { make in
            make.height.equalTo(202)
            make.top.equalTo(titleContainer.snp.bottom)
            make.leading.trailing.equalTo(stack)
        }
        
        categoryContainer.snp.makeConstraints { make in
            make.leading.equalTo(stack).offset(28)
            make.height.equalTo(48)
        }
        
        musicViewController.view.snp.makeConstraints { make in
            make.top.equalTo(categoryContainer.snp.bottom)
            make.leading.trailing.equalTo(stack)
            make.bottom.equalTo(scrollView.frameLayoutGuide)
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
}
