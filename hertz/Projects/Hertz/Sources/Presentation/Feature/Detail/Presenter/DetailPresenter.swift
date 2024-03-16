import Foundation

class DetailPresenter {
    
    private weak var delegate: DetailDelegate!
    
    private var tempUrl: URL?
    
    private var isPlaying = false
    
    func setDelegate(delegate: DetailDelegate) {
        self.delegate = delegate
    }
    
    func fetchMusic(id: Int) {
        Task {
            do {
                let data = try await MusicAPI.getMusic(id: id)
                let filename = "playing-music.mp3"
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsURL.appendingPathComponent(filename)
                
                try data.write(to: fileURL)
                
                if let tempUrl = tempUrl {
                    print("\(#function) \(tempUrl)")
                    self.tempUrl = fileURL
                } else {
                    print("\(#function) tempUrl is nil")
                }
                
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func clickStartButton() {
        if let tempUrl = tempUrl {
            DispatchQueue.main.async {
                if self.isPlaying {
                    self.delegate.stopMusic(url: tempUrl)
                } else {
                    self.delegate.playMusic(url: tempUrl)
                }
            }
            isPlaying.toggle()
        }
    }
}
