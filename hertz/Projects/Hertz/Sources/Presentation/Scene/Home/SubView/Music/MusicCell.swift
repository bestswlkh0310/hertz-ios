import UIKit
import Then

class MusicCell: BaseCollectionViewCell {
    private var container = UIButton()
    private var image = UIImageView()
    private var music = UILabel()
    private var author = UILabel()
    
    private var musicModel: Music?
    
    var onClick: ((_ tag: Int) -> ())?
    
    override func setUpStyle() {
        super.setUpStyle()
        image.do {
            $0.layer.cornerRadius = 16
        }
        container.do {
            $0.addTarget(self, action: #selector(clickMusic(_:)), for: .touchUpInside)
        }
        music.do {
            $0.textColor = .white
            $0.numberOfLines = 0
            $0.sizeToFit()
            $0.font = .systemFont(ofSize: 16, weight: .medium)
        }
        author.do {
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
        onClick?(sender.tag)
    }
    
    func setMusic(music: Music) {
        self.musicModel = music
        
        let uiImage = UIImage(named: music.image)
        
        music.do {
            self.music.text = $0.music
            self.image.image = uiImage
            self.author.text = music.author
        }
    }
    
    
    func setTag(idx: Int) {
        container.tag = idx
    }
}
