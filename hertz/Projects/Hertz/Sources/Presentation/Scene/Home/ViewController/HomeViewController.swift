import Foundation
import UIKit
import SwiftUI
import SnapKit

class HomeViewController: BaseViewController, UIScrollViewDelegate {
    
    override var isNavigationBarHidden: Bool { true }
    
    private var musics: [Music] = []
    
    private var homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAll()
        self.view = homeView
        homeView.configureDelegate(self)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            homeView.handleScrollHeight()
        }
    }
    
    @objc func clickMusic(_ sender: UIButton) {
        print("clicked")
        self.clickMusic(tag: sender.tag)
    }
    
    func displayMusics(musics: [Music]) {
//        make(musics: musics)
    }
    
    func navigateDetail(music: Music) {
        let detailVC = DetailViewController()
        detailVC.music = music
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    deinit {
        homeView.removeObserver(self, forKeyPath: "contentOffset")
        homeView.configureScrollView(observer: self, delegate: self)
    }
}

extension HomeViewController: HomeDelegate {
    func useViewController(use: (UIViewController) -> ()) {
        use(self)
    }
    
    func fetchAll() {
        Task {
            do {
                let musics = try await MusicAPI.getMusics()
                self.musics = musics
                DispatchQueue.main.async {
                    self.displayMusics(musics: musics)
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func clickMusic(tag: Int) {
        navigateDetail(music: self.musics[tag])
    }
}
