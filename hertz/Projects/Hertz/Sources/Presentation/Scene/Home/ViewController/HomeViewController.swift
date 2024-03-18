import Foundation
import UIKit
import SwiftUI
import SnapKit

class HomeViewController: BaseViewController, UIScrollViewDelegate {
    
    override var isNavigationBarHidden: Bool { true }
    
    private var musics: [Music] = [] {
        didSet {
            homeView.updateMusics(musics: musics)
        }
    }
    
    private var homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.configureDelegate(self)
        homeView.configureViewControllers()
        self.fetchAll()
        self.view = homeView
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            homeView.handleScrollHeight()
        }
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
                DispatchQueue.main.async {
                    self.musics = musics
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func clickMusic(tag: Int) {
        navigateDetail(music: musics[tag])
    }
}
