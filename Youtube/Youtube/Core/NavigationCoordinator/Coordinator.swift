import Foundation
import UIKit

protocol Coordinator: AnyObject {
  var navigation: UINavigationController { get }
  var onFinish: ((Coordinator) -> Void)? { get set }
  func start()
}

extension Coordinator {
  func finished() {
    onFinish?(self)
  }
}

protocol CoordinatorDelegate: AnyObject {
  func didFinish(_ coordinator: Coordinator)
}
