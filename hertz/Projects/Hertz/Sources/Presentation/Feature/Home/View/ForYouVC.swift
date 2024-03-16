import UIKit
import SnapKit

class ForYouCell: UICollectionViewCell {
    
    private var logo: UIImageView = {
        if let image = UIImage(named: "Logo") {
            let imageView = UIImageView(image: image)
            return imageView
        } else {
            fatalError("Logo image is missing")
        }
    }()
    
    private var title: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = .systemFont(ofSize: 16, weight: .medium)
        return l
    }()
    
    private var author: UILabel = {
        let l = UILabel()
        l.textColor = .gray500
        l.font = .systemFont(ofSize: 14, weight: .regular)
        return l
    }()
    
    public func setMusic(music: Music) {
        self.title.text = music.music
        self.author.text = music.author
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(logo)
        contentView.addSubview(title)
        contentView.addSubview(author)
        
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

class ForYouVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    let cellIdentifier = "CustomCell"
    let itemCount = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .init(0, alpha: 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ForYouCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ForYouCell
        cell.setMusic(music: Music(id: .random(in: 0..<100000),music: "연애운을 팍팍 올려주...", author: "Milo", image: "Logo"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 154, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ForYouVC - No.\(indexPath.item) collection clicked")
    }
}
