import UIKit
import SnapKit

class ForYouViewController: BaseViewController {
    
    private let itemCount = 20
    
    private var forYouView = ForYouView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = forYouView
        
        // MARK: configure
        forYouView.collectionView.do {
            $0.dataSource = self
            $0.delegate = self
        }
    }
}

extension ForYouViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = forYouView.collectionView.dequeueReusableCell(withReuseIdentifier: forYouView.cellIdentifier, for: indexPath) as! ForYouCell
        cell.setMusic(music: Music(id: .random(in: 0..<100000),music: "연애운을 팍팍 올려주...", author: "Milo", image: "Logo"))
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
