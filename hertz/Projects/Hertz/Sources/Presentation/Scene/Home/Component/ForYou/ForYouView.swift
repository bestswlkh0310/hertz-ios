import UIKit

class ForYouView: BaseView {
    
    var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    let cellIdentifier = "CustomCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setUpStyle() {
        super.setUpStyle()
        layout.do {
            $0.minimumInteritemSpacing = 16
            $0.scrollDirection = .horizontal
            $0.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        }
        
        collectionView = .init(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .init(0, alpha: 0)
            $0.showsHorizontalScrollIndicator = false
            $0.register(ForYouCell.self, forCellWithReuseIdentifier: cellIdentifier)
        }
        
    }
    
    override func configure() {
        super.configure()
        addSubview(collectionView)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCollectionView(dataSource: UICollectionViewDataSource,
                                 delegate: UICollectionViewDelegate) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    func getCell(idx: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: idx) as! ForYouCell
        cell.setMusic(music: Music(id: .random(in: 0..<100000),music: "연애운을 팍팍 올려주...", author: "Milo", image: "Logo"))
        return cell
    }
    
}
