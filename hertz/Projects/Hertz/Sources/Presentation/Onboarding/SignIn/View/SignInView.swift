import UIKit

class SignInView: BaseView {
    
    var stack = UIStackView()
    
    var emailTextField = HertzTextField()
    var passwordTextField = HertzTextField()
    
    var signUpStack = UIStackView()
    var signUpLabel = UILabel()
    var signUpButton = UIButton()
    
    var continueButton = HertzButton()
    
    override func setUpStyle() {
        super.setUpStyle()
        stack.do {
            $0.axis = .vertical
            $0.spacing = 16
        }
        
        emailTextField.do {
            $0.placeholder = "이메일"
        }
        
        passwordTextField.do {
            $0.placeholder = "비밀번호"
        }
        
        continueButton.do {
            $0.setTitle("계속하기", for: .normal)
        }
        
        signUpLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .gray500
            $0.text = "계정이 없으시다면? "
        }
        
        signUpButton.do {
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
            $0.setTitleColor(.primary500, for: .normal)
            let attributedString = NSAttributedString(string: "회원가입", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            $0.setAttributedTitle(attributedString, for: .normal)
        }
        
        signUpStack.do {
            $0.axis = .horizontal
            $0.spacing = 0
        }
    }
    
    override func configureUI() {
        super.configureUI()
        addSubviews(stack)
        stack.addArrangedSubviews(emailTextField, passwordTextField)
        addSubviews(signUpStack)
        signUpStack.addArrangedSubviews(signUpLabel, signUpButton)
        addSubviews(continueButton)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        stack.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(48)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(stack)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(stack)
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
        }
        
        signUpStack.snp.makeConstraints {
            $0.bottom.equalTo(continueButton.snp.top).offset(-16)
            $0.centerX.equalTo(self)
        }
    }
}
