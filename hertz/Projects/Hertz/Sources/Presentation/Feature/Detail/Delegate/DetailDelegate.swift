import Foundation

protocol DetailDelegate: NSObject {
    
    func fetchedMusic(url: URL)
    
    func playMusic(url: URL)
    
    func stopMusic(url: URL)
    
}
