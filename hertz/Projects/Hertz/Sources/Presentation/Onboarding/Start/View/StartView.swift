import UIKit

class StartView: BaseView {
    
    var startButton = HertzButton()
    var largeLogo = UIImageView()
    
    override func setUpStyle() {
        super.setUpStyle()
        
        startButton.do {
            $0.setTitle("시작하기", for: .normal)
        }
        
        largeLogo.do {
            let uiImage = UIImage(named: "LargeLogo")
            $0.image = uiImage
        }
    }
    
    override func configureUI() {
        super.configureUI()
        addSubviews(largeLogo, startButton)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        largeLogo.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(180)
            $0.centerX.equalTo(self)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
        }
    }
}
