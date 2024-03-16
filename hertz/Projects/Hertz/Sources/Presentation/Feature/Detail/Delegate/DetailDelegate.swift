import Foundation

protocol DetailDelegate: NSObject {
    
    func playMusic(url: URL)
    
    func stopMusic(url: URL)
    
}
