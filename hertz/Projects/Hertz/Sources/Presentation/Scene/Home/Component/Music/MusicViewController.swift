import UIKit

class MusicViewController: BaseViewController {
    
    private var musics: [Music] = []
    
    private var musicView = MusicView()
    
    var onClick: ((_ tag: Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = musicView
        musicView.configureCollectionView(dataSource: self, delegate: self)
    }
    
    func updateMusics(musics: [Music]) {
        self.musics = musics
        musicView.reloadCollectionView()
    }
}

extension MusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = musicView.getCell(idx: indexPath)
        cell.setMusic(music: musics[indexPath.item])
        cell.setTag(idx: indexPath.item)
        if let onClick {
            cell.setOnClick(onClick)
        }
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
