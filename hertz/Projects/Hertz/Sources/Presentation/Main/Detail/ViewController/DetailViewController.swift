import UIKit
import Then
import SnapKit
import MediaPlayer
import AVKit

protocol DetailDelegate: NSObject {
    
}

class DetailViewController: BaseViewController, UINavigationControllerDelegate, AVAudioPlayerDelegate {
    var music: Music!
    
    private var playIcon = UIImage(named: "Play")!.resizeImage(targetSize: .init(width: 84, height: 64))
    private var pauseIcon = UIImage(named: "Pause")!.resizeImage(targetSize: .init(width: 84, height: 64))
    
    private var detailView = DetailView()
    
    private var totalDate: Date?
    
    private var timer: Timer?
    
    private var audioPlayer: AVAudioPlayer?
    
    private var tempUrl: URL?
    
    private var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "재생중" // TODO: rm dummy
        self.view = detailView
        
        // MARK: configure
        navigationController?.delegate = self
        detailView.delegate = self
        configureNavigationController()
        setAddTarget()
    }
    
    func configureNavigationController() {
        guard let navigationController = self.navigationController else { return }
        navigationController.do {
            $0.navigationBar.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]
            $0.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMusic(id: music.id)
    }
    
    func setAddTarget() {
        detailView.slider.addTarget(self, action: #selector(sliderChanded), for: .touchUpInside)
        
        detailView.startButton.addTarget(self, action: #selector(handleClickStart), for: .touchUpInside)
    }
    
    func fetchedMusic(url: URL) {
        if let date = url.musicDate {
            totalDate = date
        }
        let c = url.musicDate?.components
        if let m = c?.minute,
           let s = c?.second {
            detailView.startTime.text = "0:00"
            detailView.endTime.text = .init(format: "%d:%02d", arguments: [m, s])
        }
    }

    func playMusic(url: URL) {
        do {
            detailView.startButton.setImage(pauseIcon, for: .normal)
            print("play...")
            audioPlayer = try AVAudioPlayer(contentsOf: url).then {
                $0.prepareToPlay()
                $0.delegate = self
                $0.volume = 1
                $0.play()
            }
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudio), userInfo: nil, repeats: true)
            
        } catch {
            print("error...")
            debugPrint(error)
        }
        // TODO: Change Icon
    }
    
    func stopMusic(url: URL) {
        // TODO: Change Icon
        detailView.startButton.setImage(playIcon, for: .normal)
        print("\(#function) - stop music")
        if let audioPlayer = audioPlayer {
            audioPlayer.pause()
        }
        
    }
    
    @objc func updateAudio() {
        guard let audioPlayer = audioPlayer else { return }
        let currentTime = audioPlayer.currentTime
        let c = Date(timeIntervalSince1970: currentTime).components
        if let m = c.minute,
           let s = c.second {
            detailView.startTime.text = .init(format: "%d:%02d", arguments: [m, s])
            if let totalDate = totalDate {
                detailView.slider.value = Float(currentTime / totalDate.timeIntervalSince1970)
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension DetailViewController: DetailDelegate {
    
    func fetchMusic(id: Int) {
        Task {
            do {
                let result = await NetworkService.shared.musicService.getMusic(id: id)
                switch result {
                case .success(let data):
                    let filename = "playing-music.mp3"
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsURL.appendingPathComponent(filename)
                    try data.write(to: fileURL)
                    print("\(#function) \(fileURL)")
                    self.tempUrl = fileURL
                    DispatchQueue.main.async {
                        self.fetchedMusic(url: fileURL)
                    }
                default:
                    // TODO: handle error
                    break
                }
                
            } catch {
                debugPrint(error)
            }
        }
    }
    
    @objc
    func handleClickStart() {
        if let tempUrl = tempUrl {
            DispatchQueue.main.async {
                if self.isPlaying {
                    self.stopMusic(url: tempUrl)
                } else {
                    self.playMusic(url: tempUrl)
                }
                self.isPlaying.toggle()
            }
        }
    }
    
    @objc
    func sliderChanded(_ sender: UISlider) {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.currentTime = (totalDate?.timeIntervalSince1970 ?? 0) * Double(sender.value)
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
