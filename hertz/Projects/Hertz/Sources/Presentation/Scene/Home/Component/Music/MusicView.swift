import UIKit

class MusicView: BaseView {
    
    private var collectionView: UICollectionView!
    private var layout = UICollectionViewFlowLayout()
    
    private let cellIdentifier = "MusicCell"
    
    override func setUpStyle() {
        super.setUpStyle()
        layout.do {
            $0.scrollDirection = .vertical
        }
        
        collectionView = .init(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .init(0, alpha: 0)
            $0.showsVerticalScrollIndicator = false
            $0.register(MusicCell.self, forCellWithReuseIdentifier: cellIdentifier)
//            $0.isUserInteractionEnabled = false
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
    
    func getCell(idx: IndexPath) -> MusicCell {
        if collectionView == nil {
            print("collectionView is nil")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: idx) as! MusicCell
        return cell
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
}
