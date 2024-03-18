import UIKit

class MusicViewController: BaseViewController {
    
    private var musics: [Music] = Array(repeating: .init(id: .random(in: 0..<100000), music: "123", author: "1234", image: "Logo"), count: 100)
    
    private var musicView = MusicView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = musicView
        musicView.configureCollectionView(dataSource: self, delegate: self)
    }
    
    func updateMusics(musics: [Music]) {
        print(musics)
        self.musics = musics
        musicView.reloadCollectionView()
    }
}

extension MusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 72)
    }
    
}

extension MusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = musicView.getCell(idx: indexPath)
        cell.setMusic(music: musics[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(#file) - No.\(indexPath.item) collection clicked")
    }
    
}

