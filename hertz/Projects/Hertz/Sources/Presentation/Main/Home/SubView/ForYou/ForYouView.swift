import UIKit

class ForYouView: BaseView {
    
    var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    let cellIdentifier = "ForYouCell"
    
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
    
    override func configureUI() {
        super.configureUI()
        addSubview(collectionView)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
