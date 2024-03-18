import Foundation

class HomePresenter {
    
    weak private var delegate: HomeDelegate!
    
    private var musics: [Music] = []
    
    func setDelegate(delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    func fetchAll() {
        Task {
            do {
                let musics = try await MusicAPI.getMusics()
                self.musics = musics
                DispatchQueue.main.async {
                    self.delegate.displayMusics(musics: musics)
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func clickMusic(tag: Int) {
        print("\(#function) \(tag)")
        delegate.navigateDetail(music: self.musics[tag])
    }
}
