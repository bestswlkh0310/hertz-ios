import AVKit

extension URL {
    var musicDate: Date? {
        do {
            let asset = AVURLAsset(url: self)
            let audioDuration = asset.duration
            let audioDurationSeconds = CMTimeGetSeconds(audioDuration)
            return Date(timeIntervalSince1970: audioDurationSeconds)
        } catch {
            print("Error getting music duration: \(error)")
            return nil
        }
    }
    
}
