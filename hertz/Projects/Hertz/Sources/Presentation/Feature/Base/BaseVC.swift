import UIKit

open class BaseVC: UIViewController, BaseProtocol {
    
    var isNavigationBarHidden: Bool { false }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray800
        setUpStyle()
        configure()
        setUpLayout()
    }
    
    open func setUpStyle() {}
    
    open func configure() {}
    
    open func setUpLayout() {}
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNavigationBarHidden, let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isNavigationBarHidden, let navigationController = navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
}
