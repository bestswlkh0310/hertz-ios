import UIKit
import AVKit

class DetailView: BaseView {
    
    var backButton = UIBarButtonItem()
    
    var playIcon = UIImage(named: "Play")!.resizeImage(targetSize: .init(width: 84, height: 64))
    var pauseIcon = UIImage(named: "Pause")!.resizeImage(targetSize: .init(width: 84, height: 64))
    
    var image = UIImageView()
    
    var infoStack = UIStackView()
    
    var titleLabel = UILabel()
    
    var author = UILabel()
    
    var slider = UISlider()
    
//    var progressObserver: NSKeyValueObservation!
    
    var timeStack = UIStackView()
    
    var startTime = UILabel()
    
    var endTime = UILabel()
    
    var startButton = UIButton()
    
    var beforeButton = UIButton()
    
    var afterButton = UIButton()
    
    var delegate: DetailDelegate!
    
    override func setUpStyle() {
        super.setUpStyle()
        
        image.do {
            $0.image = UIImage(named: "Logo")
        }
        
        infoStack.do {
            $0.axis = .vertical
            $0.spacing = 0
            $0.distribution = .fill
            $0.isLayoutMarginsRelativeArrangement = true
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = .white
        }
        
        author.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .gray500
        }
        
        slider.do {
            $0.minimumValue = 0.0
            $0.maximumValue = 1.0
            $0.value = 0.0
            $0.minimumTrackTintColor = .gray200
            $0.maximumTrackTintColor = .gray700
            $0.thumbTintColor = .white
            let thumb = UIImage(named: "Thumb")?.resizeImage(targetSize: .init(width: 14, height: 14))
            $0.setThumbImage(thumb, for: .normal)
        }
        
        timeStack.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.distribution = .equalSpacing
        }
        
        startTime.do {
            $0.text = "-"
            $0.textColor = .gray500
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
        
        endTime.do {
            $0.text = "-"
            $0.textColor = .gray500
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
        
        startButton.do {
            let uiImage = playIcon
            $0.setImage(uiImage, for: .normal)
        }
        
        beforeButton.do {
            let uiImage = UIImage(named: "Before")
            $0.setImage(uiImage, for: .normal)
        }
        
        afterButton.do {
            let uiImage = UIImage(named: "Before")?.withHorizontallyFlippedOrientation()
            $0.setImage(uiImage, for: .normal)
        }
        
        backButton.do {
            $0.title = "<"
            $0.style = .plain
        }
    }
    
    override func configureUI() {
        super.configureUI()
        addSubviews(image, infoStack)
        infoStack.addArrangedSubviews(titleLabel, author, slider, timeStack)
        timeStack.addArrangedSubviews(startTime, endTime)
        addSubviews(beforeButton, startButton, afterButton)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        image.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.height.equalTo(306)
        }
        
        infoStack.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).offset(-24)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoStack)
            make.bottom.equalTo(author.snp.top).offset(-4)
        }
        
        author.snp.makeConstraints { make in
            make.bottom.equalTo(slider.snp.top).offset(-16)
            make.leading.equalTo(infoStack)
        }
        
        slider.snp.makeConstraints { make in
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
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-92)
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
    
    func configureNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.leftBarButtonItem = backButton
    }
}
