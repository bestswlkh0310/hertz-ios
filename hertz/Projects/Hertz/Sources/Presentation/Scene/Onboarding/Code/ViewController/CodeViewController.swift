import UIKit

class CodeViewController: BaseViewController {
    
    let codeView = CodeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = codeView
        title = "이메일 인증"
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
        
    }
    
    @objc
    func navigateSignIn() {
        let codeViewController = CodeViewController()
        navigationController?.pushViewController(codeViewController, animated: true)
    }
}

extension CodeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
