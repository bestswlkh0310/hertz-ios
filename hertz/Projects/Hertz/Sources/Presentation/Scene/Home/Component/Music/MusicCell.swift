import UIKit
import Then

class MusicCell: BaseCollectionViewCell {
    var container = UIButton()
    var image = UIImageView()
    var music = UILabel()
    var author = UILabel()
    
    var musicModel: Music!
    
    var onClick: (() -> ())!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setUpStyle() {
        super.setUpStyle()
        image.do {
            let uiImage = UIImage(named: musicModel.image)
            $0.image = uiImage
            $0.layer.cornerRadius = 16
        }
        container.do {
            $0.addTarget(self, action: #selector(clickMusic(_:)), for: .touchUpInside)
//            $0.tag = idx
        }
        music.do {
            $0.text = musicModel.music
            $0.textColor = .white
            $0.numberOfLines = 0
            $0.sizeToFit()
            $0.font = .systemFont(ofSize: 16, weight: .medium)
        }
        author.do {
            $0.text = musicModel.author
            $0.textColor = .gray500
            $0.numberOfLines = 0
            $0.sizeToFit()
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    override func configure() {
        super.configure()
        contentView.addSubview(container)
        container.addSubview(image)
        container.addSubview(music)
        container.addSubview(author)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        container.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.leading.trailing.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.top.bottom.equalTo(container)
            make.leading.equalTo(container)
            make.width.height.equalTo(54)
        }
        music.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.trailing.equalTo(container)
            make.top.equalTo(image).offset(4)
        }
        author.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.top.equalTo(music.snp.bottom).offset(2)
            make.trailing.equalTo(container)
        }
    }
    
    @objc
    func clickMusic(_ sender: UIButton) {
        onClick()
    }
    
    func setMusic(music: Music) {
        self.musicModel = music
    }
}
