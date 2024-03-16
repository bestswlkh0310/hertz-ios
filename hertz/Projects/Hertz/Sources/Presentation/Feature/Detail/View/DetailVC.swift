import UIKit
import Then
import SnapKit
import AVKit

class DetailVC: BaseVC, UINavigationControllerDelegate, DetailDelegate, AVAudioPlayerDelegate {
    var music: Music!
    
    private var playIcon = UIImage(named: "Play")?.resizeImage(targetSize: .init(width: 84, height: 64))
    private var pauseIcon = UIImage(named: "Pause")?.resizeImage(targetSize: .init(width: 84, height: 64))
    
    private var backButton: UIBarButtonItem!
    
    private var image: UIImageView!
    
    private var infoStack: UIStackView!
    
    private var titleLabel: UILabel!
    
    private var author: UILabel!
    
    private var progressBar: UISlider!
    
    private var progressObserver: NSKeyValueObservation!
    
    private var timeStack: UIStackView!
    
    private var startTime: UILabel!
    
    private var endTime: UILabel!
    
    private var startButton: UIButton!
    
    private var beforeButton: UIButton!
    
    private var afterButton: UIButton!
    
    private var detailPresenter = DetailPresenter()
    
    private var audioPlayer: AVAudioPlayer!
    
    private var totalDate: Date?
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "재생중" // TODO: rm dummy
        self.backButton = .init(title: "<", style: .plain, target: self, action: #selector(backButtonTapped))
        detailPresenter.setDelegate(delegate: self)
        navigationController?.delegate = self
        navigationItem.leftBarButtonItem = backButton
        if let navigationController = self.navigationController {
            navigationController.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailPresenter.fetchMusic(id: music.id)
    }
    
    override func setUpStyle() {
        if let navigationController = self.navigationController {
            navigationController.navigationBar.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]
        }
        
        image = .init().then {
            let uiImage = UIImage(named: music.image)
            $0.image = uiImage
        }
        
        infoStack = .init().then {
            $0.axis = .vertical
            $0.spacing = 0
            $0.distribution = .fill
            $0.isLayoutMarginsRelativeArrangement = true
        }
        
        titleLabel = .init().then {
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = .white
            $0.text = music.music
        }
        
        author = .init().then {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .gray500
            $0.text = music.author
        }
        
        progressBar = .init().then {
            $0.minimumValue = 0.0
            $0.maximumValue = 1.0
            $0.value = 0.0
            $0.minimumTrackTintColor = .gray200
            $0.maximumTrackTintColor = .gray700
            $0.thumbTintColor = .white
            let thumb = UIImage(named: "Thumb")
            $0.setThumbImage(thumb, for: .normal)
        }
        
        timeStack = .init().then {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.distribution = .equalSpacing
        }
        
        startTime = .init().then {
            $0.text = "-"
            $0.textColor = .gray500
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
        
        endTime = .init().then {
            $0.text = "-"
            $0.textColor = .gray500
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
        
        startButton = .init().then {
            let uiImage = playIcon
            $0.setImage(uiImage, for: .normal)
            $0.addTarget(self, action: #selector(clickStartButton), for: .touchUpInside)
        }
        
        beforeButton = .init().then {
            let uiImage = UIImage(named: "Before")
            $0.setImage(uiImage, for: .normal)
        }
        
        afterButton = .init().then {
            let uiImage = UIImage(named: "Before")?.withHorizontallyFlippedOrientation()
            $0.setImage(uiImage, for: .normal)
        }
    }
    
    override func configure() {
        view.addSubview(image)
        view.addSubview(infoStack)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(author)
        infoStack.addArrangedSubview(progressBar)
        infoStack.addArrangedSubview(timeStack)
        timeStack.addArrangedSubview(startTime)
        timeStack.addArrangedSubview(endTime)
        view.addSubview(startButton)
        view.addSubview(beforeButton)
        view.addSubview(afterButton)
    }
    
    override func setUpLayout() {
        image.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(306)
        }
        
        infoStack.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).offset(-24)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoStack)
            make.bottom.equalTo(author.snp.top).offset(-4)
        }
        
        author.snp.makeConstraints { make in
            make.bottom.equalTo(progressBar.snp.top).offset(-16)
            make.leading.equalTo(infoStack)
        }
        
        progressBar.snp.makeConstraints { make in
            make.leading.equalTo(infoStack)
            make.trailing.equalTo(infoStack)
            make.bottom.equalTo(timeStack.snp.top).offset(-8)
        }
        
        timeStack.snp.makeConstraints { make in
        }
        
        startTime.snp.makeConstraints { make in
            make.leading.equalTo(timeStack)
        }
        
        endTime.snp.makeConstraints { make in
            make.trailing.equalTo(timeStack)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-92)
        }
        
        beforeButton.snp.makeConstraints { make in
            make.centerY.equalTo(startButton)
            make.trailing.equalTo(startButton.snp.leading).offset(-48)
        }
        
        afterButton.snp.makeConstraints { make in
            make.centerY.equalTo(startButton)
            make.leading.equalTo(startButton.snp.trailing).offset(48)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func clickStartButton() {
        detailPresenter.clickStartButton()
    }
    
    func fetchedMusic(url: URL) {
        if let date = url.musicDate {
            totalDate = date
        }
        let c = url.musicDate?.components
        if let m = c?.minute,
           let s = c?.second {
            startTime.text = "0:00"
            endTime.text = String(format: "%d:%02d", arguments: [m, s])
        }
    }

    func playMusic(url: URL) {
        do {
            startButton.setImage(pauseIcon, for: .normal)
            print("play...")
            print(url.absoluteURL)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            audioPlayer.volume = 1
            audioPlayer.play()
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudio), userInfo: nil, repeats: true)
            
            
        } catch {
            print("error...")
            debugPrint(error)
        }
        // TODO: Change Icon
    }
    
    func stopMusic(url: URL) {
        // TODO: Change Icon
        startButton.setImage(playIcon, for: .normal)
        print("\(#function) - stop music")
        if let audioPlayer = audioPlayer {
            audioPlayer.pause()
        }
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.navigationBar.tintColor = .white
    }
    
    @objc func updateAudio() {
        let currentTime = audioPlayer.currentTime
        let c = Date(timeIntervalSince1970: currentTime).components
        if let m = c.minute,
           let s = c.second {
            startTime.text = String(format: "%d:%02d", arguments: [m, s])
            if let totalDate = totalDate {
                progressBar.value = Float(currentTime / totalDate.timeIntervalSince1970)
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}


extension DetailVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
