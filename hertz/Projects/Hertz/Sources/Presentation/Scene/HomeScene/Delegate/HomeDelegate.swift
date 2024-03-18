import Foundation

protocol HomeDelegate: NSObjectProtocol {
    func displayMusics(musics: [Music])
    func navigateDetail(music: Music)
}
