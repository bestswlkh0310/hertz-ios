import UIKit

class SignInViewController: BaseViewController {
    
    let signInView = SignInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = signInView
        title = "로그인"
        hideKeyboardWhenTappedAround()
        
        // MARK: configure
        configureAddTarget()
        dismiss = {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureAddTarget() {
        signInView.signUpButton.addTarget(self, action: #selector(navigateSignUp), for: .touchUpInside)
    }
    
    @objc
    func navigateSignUp() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}

extension SignInViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
