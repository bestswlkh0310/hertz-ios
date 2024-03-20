import UIKit

class MusicViewController: BaseViewController {
    
    var musics: [Music] = [] {
        didSet {
            musicView.collectionView.reloadData()
            updateMusicContainerHeight?(musics.count)
        }
    }
    
    private var musicView = MusicView()
    
    var updateMusicContainerHeight: ((Int) -> ())?
    var onClick: ((_ tag: Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = musicView
        
        // MARK: configure
        musicView.collectionView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
}

extension MusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: musicView.cellIdentifier, for: indexPath) as! MusicCell
        cell.setMusic(music: musics[indexPath.item])
        cell.setTag(idx: indexPath.item)
        cell.onClick = onClick
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(#file) - No.\(indexPath.item) collection clicked")
    }
}


extension MusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 72)
    }
    
}
