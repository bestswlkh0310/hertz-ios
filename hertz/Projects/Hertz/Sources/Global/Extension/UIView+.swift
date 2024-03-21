import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    func showToast(message: String, at: CGFloat = 136) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = .black
        toastLabel.textColor = .gray300
        toastLabel.textAlignment = .center
        toastLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true
        
        let toastWidth: CGFloat = 253
        let toastHeight: CGFloat = 42
        toastLabel.frame = CGRect(x: self.frame.size.width / 2 - toastWidth / 2,
                                  y: self.frame.size.height - toastHeight - at,
                                  width: toastWidth,
                                  height: toastHeight)
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(toastLabel)
        }
        
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseOut) {
            toastLabel.alpha = 0.0
        } completion: { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
