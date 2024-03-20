import UIKit

class MusicView: BaseView {
    
    var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    let cellIdentifier = "MusicCell"
    
    override func setUpStyle() {
        super.setUpStyle()
        layout.do {
            $0.scrollDirection = .vertical
        }
        
        collectionView = .init(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .init(0, alpha: 0)
            $0.showsVerticalScrollIndicator = false
            $0.register(MusicCell.self, forCellWithReuseIdentifier: cellIdentifier)
            $0.isUserInteractionEnabled = false
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
