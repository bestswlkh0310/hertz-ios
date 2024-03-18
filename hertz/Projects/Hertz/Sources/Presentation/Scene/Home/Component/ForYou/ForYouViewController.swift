import UIKit
import SnapKit

class ForYouViewController: BaseViewController {
    
    private let itemCount = 20
    
    private var forYouView = ForYouView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = forYouView
        forYouView.configureCollectionView(dataSource: self, delegate: self)
    }
}

extension ForYouViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = forYouView.getCell(idx: indexPath)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ForYouVC - No.\(indexPath.item) collection clicked")
    }
}

extension ForYouViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 154, height: collectionView.bounds.height)
    }
    
}
