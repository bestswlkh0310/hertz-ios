import Foundation
import UIKit

protocol HomeDelegate: NSObjectProtocol {
    func fetchAll()
    func clickMusic(tag: Int)
    func useViewController(use: (UIViewController) -> ())
}
