import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStyle()
        configure()
        setUpLayout()
    }
    
    func setUpStyle() {}
    
    func configure() {}
    
    func setUpLayout() {}
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
