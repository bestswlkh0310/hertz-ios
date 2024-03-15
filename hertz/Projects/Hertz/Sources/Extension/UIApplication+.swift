import UIKit

extension UIApplication {
    
    public class func findWindow() -> UIWindow? {
        return shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    public class var window: UIWindow? {
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
                                
        if let windowScene = scene as? UIWindowScene {
            return windowScene.keyWindow
        } else {
            return nil
        }
        
    }
}
