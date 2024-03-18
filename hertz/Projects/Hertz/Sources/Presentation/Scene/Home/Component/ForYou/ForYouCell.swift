import UIKit

class ForYouCell: BaseCollectionViewCell {
    
    private var logo = UIImageView()
    
    private var title = UILabel()
    
    private var author = UILabel()
    
    private var music: Music?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setMusic(music: Music) {
        self.title.text = music.music
        self.author.text = music.author
    }
    
    override func setUpStyle() {
        super.setUpStyle()
        logo.do {
            let image = UIImage(named: "Logo")
            $0.image = image
        }
        title.do {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 16, weight: .medium)
        }
        author.do {
            $0.textColor = .gray500
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    override func configure() {
        super.configure()
        
        contentView.addSubview(logo)
        contentView.addSubview(title)
        contentView.addSubview(author)
        
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        logo.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(contentView)
            make.height.equalTo(154)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(10)
            make.height.equalTo(19)
            make.leading.equalTo(contentView)
        }
        
        author.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(2)
            make.leading.bottom.equalTo(contentView)
            make.height.equalTo(17)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
