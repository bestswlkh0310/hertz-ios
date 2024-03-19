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
        leftView = .init(frame: .init(x: 0, y: 0, width: 16, height: 0))
        leftViewMode = .always
        rightView = .init(frame: .init(x: 0, y: 0, width: 16, height: 0))
        rightViewMode = .always
        
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
