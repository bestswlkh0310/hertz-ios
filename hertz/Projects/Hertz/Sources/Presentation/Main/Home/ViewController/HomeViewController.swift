import Foundation
import UIKit
import SwiftUI
import SnapKit

protocol HomeDelegate: NSObjectProtocol {
    
    func clickMusic(tag: Int)
    
    func updateMusicContainerHeight(count: Int)
    
}

class HomeViewController: BaseViewController, UIScrollViewDelegate {
    
    override var isNavigationBarHidden: Bool { true }
    
    var showShadow = false {
        didSet {
            if showShadow {
                homeView.gnbBar.layer.shadowOpacity = 0.16
            } else {
                homeView.gnbBar.layer.shadowOpacity = 0.0
            }
        }
    }
    
    private var homeView = HomeView()
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: configure
        homeView.delegate = self
        configureChildVC()
        configureScrollView()
        configureMusicCellTapped()
        setAddTarget()
        
        // MARK: fetch
        self.fetchAll()
    }
    
    func configureChildVC() {
        addChild(homeView.banner)
        homeView.banner.didMove(toParent: self)
        
        addChild(homeView.forYouVC)
        homeView.forYouVC.didMove(toParent: self)
        
        addChild(homeView.musicViewController)
        homeView.musicViewController.didMove(toParent: self)
    }
    
    func setAddTarget() {
        homeView.profileButton.addTarget(self, action: #selector(navigateProfileView), for: .touchUpInside)
    }
    
    
    func configureScrollView() {
        homeView.scrollView.do {
            $0.addObserver(self, forKeyPath: "contentOffset", options:. new, context: nil)
            $0.delegate = self
        }
    }
    
    func configureMusicCellTapped() {
        homeView.musicViewController.onClick = {
            self.clickMusic(tag: $0)
        }
    }
    
    @objc
    func navigateProfileView() {
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    
    func navigateDetail(music: Music) {
        let detailVC = DetailViewController()
        detailVC.music = music
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            let y = homeView.scrollView.contentOffset.y
            if y > homeView.gnbHeight && !showShadow {
                showShadow = true
            } else if y <= homeView.gnbHeight && showShadow {
                showShadow = false
            }
        }
    }
    
    deinit {
        homeView.removeObserver(self, forKeyPath: "contentOffset")
        homeView.scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
}

// MARK: http service
extension HomeViewController {
    
    func fetchAll() {
        Task {
            let response = await NetworkService.shared.musicService.getMusics()
            switch response {
            case .success(let data):
                DispatchQueue.main.async {
                    print("try apply music")
                    self.homeView.musicViewController.musics = data.data.map { $0.toDomain() }
                    print("fetching music - success")
                }
            default:
                print("\(#function) - \(response)")
                break
            }
        }
    }
}

// MARK: delegate
extension HomeViewController: HomeDelegate {
    func clickMusic(tag: Int) {
        let musics = homeView.musicViewController.musics
        navigateDetail(music: musics[tag])
    }
    func updateMusicContainerHeight(count: Int) {
        homeView.updateMusicContainerHeight(count: count)
    }
    
    
}
