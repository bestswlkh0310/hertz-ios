import UIKit

class HertzButton: UIButton {
    
    let buttonHeight: CGFloat = 56
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStyle()
        configureUI()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpStyle() {
        backgroundColor = .primary500
        layer.cornerRadius = buttonHeight / 2
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    func configureUI() {
        snp.makeConstraints {
            $0.height.equalTo(buttonHeight)
        }
    }
    
    func setUpLayout() {
        
    }
}
