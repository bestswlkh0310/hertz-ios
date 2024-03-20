import UIKit

class CodeView: BaseView {
    
    var stack = UIStackView()
    
    var codeTextField = HertzTextField()
    
    var continueButton = HertzButton()
    
    override func setUpStyle() {
        super.setUpStyle()
        stack.do {
            $0.axis = .vertical
            $0.spacing = 16
        }
        
        codeTextField.do {
            $0.placeholder = "코드"
        }
        
        continueButton.do {
            $0.setTitle("계속하기", for: .normal)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        addSubviews(stack)
        stack.addArrangedSubviews(codeTextField)
        addSubviews(continueButton)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        stack.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(48)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
        }
        
        codeTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(stack)
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
        }
    }
}
