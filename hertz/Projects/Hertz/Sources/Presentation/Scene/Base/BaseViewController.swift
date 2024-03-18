import UIKit

class BaseViewController: UIViewController {
    
    var isNavigationBarHidden: Bool { false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray800
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
}
