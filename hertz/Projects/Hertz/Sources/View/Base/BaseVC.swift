import UIKit

open class BaseVC: UIViewController {
    
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
}
