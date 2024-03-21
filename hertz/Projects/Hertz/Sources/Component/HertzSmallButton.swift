import UIKit

class HertzSmallButton: UIButton {
    
    let buttonHeight: CGFloat = 38
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStyle()
        configureUI()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return .init(width: baseSize.width + 18 * 2, height: baseSize.height)
        }
    }
    
    func setUpStyle() {
        backgroundColor = .primary500
        layer.cornerRadius = buttonHeight / 2
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func configureUI() {
        snp.makeConstraints {
            $0.height.equalTo(buttonHeight)
        }
    }
    
    func setUpLayout() {
        
    }
}
