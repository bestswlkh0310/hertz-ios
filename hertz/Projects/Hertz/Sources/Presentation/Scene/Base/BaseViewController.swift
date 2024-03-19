import UIKit

class BaseViewController: UIViewController {
    
    var isNavigationBarHidden: Bool { false }
    var dismiss: (() -> ())?
    
    let backButton = UIBarButtonItem().then {
        $0.title = "<"
        $0.style = .plain
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray800
        
        if !isNavigationBarHidden {
            configureNavigationBar()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNavigationBarHidden, let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isNavigationBarHidden, let navigationController = navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
    
    func configureNavigationBar() {
        guard let navigationController = self.navigationController else { return }
        navigationController.do {
            $0.navigationBar.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]
        }
        navigationItem.leftBarButtonItem = backButton
        
        backButton.do {
            $0.action = #selector(backButtonTapped)
            $0.target = self
            $0.tintColor = .white
        }
    }
    
    @objc
    func backButtonTapped() {
        if let dismiss {
            dismiss()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
