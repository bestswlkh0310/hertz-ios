import UIKit
import Then
import SnapKit
import AVKit

class DetailVC: BaseVC, UINavigationControllerDelegate, DetailDelegate, AVAudioPlayerDelegate {
    var music: Music!
    
    private var backButton: UIBarButtonItem!
    
    private var image: UIImageView!
    
    private var infoStack: UIStackView!
    
    private var titleLabel: UILabel!
    
    private var author: UILabel!
    
    private var progressBar: UIProgressView!
    
    private var progressObserver: NSKeyValueObservation!
    
    private var timeStack: UIStackView!
    
    private var startTime: UILabel!
    
    private var endTime: UILabel!
    
    private var startButton: UIButton!
    
    private var beforeButton: UIButton!
    
    private var afterButton: UIButton!
    
    private var detailPresenter = DetailPresenter()
    
    private var audioPlayer: AVAudioPlayer!
    
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
        
        progressBar = .init(progressViewStyle: .default).then {
            $0.progress = 0.3
            $0.progressTintColor = .gray200
            $0.trackTintColor = .gray700
        }
        
        timeStack = .init().then {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.distribution = .equalSpacing
        }
        
        startTime = .init().then {
            $0.text = "0:03"
            $0.textColor = .gray500
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
        
        endTime = .init().then {
            $0.text = "2:36"
            $0.textColor = .gray500
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
        
        startButton = .init().then {
            let uiImage = UIImage(named: "Play")?.resizeImage(targetSize: .init(width: 84, height: 64))
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
        
        progressObserver = progressBar.observe(\.progress, options: [.new]) { progressBar, change in
            if let newValue = change.newValue {
                
            }
        }
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
    

    func playMusic(url: URL) {
        do {
            print("play...")
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.play()
        } catch {
            debugPrint(error)
        }
        // TODO: Change Icon
    }
    
    func stopMusic(url: URL) {
        // TODO: Change Icon
        print("\(#function) - stop music")
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.navigationBar.tintColor = .white
    }
}


extension DetailVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
