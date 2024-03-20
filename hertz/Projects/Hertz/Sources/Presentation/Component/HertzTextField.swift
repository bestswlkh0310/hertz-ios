import UIKit

class HertzTextField: UITextField {
    
    let textFieldHeight: CGFloat = 58
    
    
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
        textColor = .white
        tintColor = .gray500
        backgroundColor = .gray700
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray600.cgColor
        addLeftPadding(16)
        addRightPadding(16)
        
        autocorrectionType = .no
        spellCheckingType = .no
    }
    
    func configureUI() {
        snp.makeConstraints {
            $0.height.equalTo(textFieldHeight)
        }
    }
    
    func setUpLayout() {
        
    }
    
}
