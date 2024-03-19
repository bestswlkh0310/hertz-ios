import UIKit

class StartViewController: BaseViewController {
    
    override var isNavigationBarHidden: Bool { true }
    
    let startView = StartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = startView
        
        // MARK: configure
        setAddTarget()
    }
    
    func setAddTarget() {
        startView.startButton.addTarget(self, action: #selector(navigateSignIn), for: .touchUpInside)
    }
    
    @objc
    func navigateSignIn() {
        let signInViewController = SignInViewController()
        navigationController?.pushViewController(signInViewController, animated: true)
    }
    
}
