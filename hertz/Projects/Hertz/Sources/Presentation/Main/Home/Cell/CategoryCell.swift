import UIKit

class CategoryCell: BaseView {
    
    var button = UIButton()
    
    var isSelected = false {
        didSet {
            let titleColor: UIColor = isSelected ? .white : .gray500
            button.setTitleColor(titleColor, for: .normal)
        }
    }
    
    override func setUpStyle() {
        super.setUpStyle()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
}
