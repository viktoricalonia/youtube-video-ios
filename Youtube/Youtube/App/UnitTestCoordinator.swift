import Foundation
import UIKit

final class UnitTestCoordinator: Coordinator {
  var children: [Coordinator] = []

  var onFinish: ((Coordinator) -> Void)?

  let window: UIWindow

  var navigation: UINavigationController = UINavigationController()

  init(
    window: UIWindow
  ) {
    self.window = window
  }

  func start() {
    window.setRootViewControllerAnimated(nil)
    pusHomeController()
    window.makeKeyAndVisible()
  }
}

extension UnitTestCoordinator {
  func pusHomeController() {
    let nav = UINavigationController(rootViewController: UIViewController())
    window.setRootViewControllerAnimated(nav)
  }
}
