import UIKit
import AVKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        window = UIWindow()
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        if let userInfo = launchOptions?[.url] as? [AnyHashable: Any] {
            print(userInfo)
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            print("AVAudio Setting loaded")
        } catch {
            print("AVAudio Setting error")
            debugPrint(error)
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}
}
