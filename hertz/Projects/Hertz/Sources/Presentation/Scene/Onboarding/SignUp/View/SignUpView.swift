import UIKit

class SignUpView: BaseView {
    
    var stack = UIStackView()
    
    var emailTextField = HertzTextField()
    var passwordTextField = HertzTextField()
    var passwordCheckTextField = HertzTextField()
    
    var signInStack = UIStackView()
    var signInLabel = UILabel()
    var signInButton = UIButton()
    
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
        
        passwordCheckTextField.do {
            $0.placeholder = "비밀번호 재입력"
        }
        
        continueButton.do {
            $0.setTitle("계속하기", for: .normal)
        }
        
        signInLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .gray500
            $0.text = "계정이 있으시다면? "
        }
        
        signInButton.do {
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
            let attributedString = NSAttributedString(string: "로그인", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            $0.setAttributedTitle(attributedString, for: .normal)
            $0.setTitleColor(.primary500, for: .normal)
        }
        
        signInStack.do {
            $0.axis = .horizontal
            $0.spacing = 0
        }
    }
    
    override func configureUI() {
        super.configureUI()
        addSubviews(stack)
        stack.addArrangedSubviews(emailTextField, passwordTextField, passwordCheckTextField)
        addSubviews(signInStack)
        signInStack.addArrangedSubviews(signInLabel, signInButton)
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
        
        passwordCheckTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(stack)
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
        }
        
        signInStack.snp.makeConstraints {
            $0.bottom.equalTo(continueButton.snp.top).offset(-16)
            $0.centerX.equalTo(self)
        }
    }
    
}
