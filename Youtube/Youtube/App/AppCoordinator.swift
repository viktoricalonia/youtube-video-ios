import Foundation
import UIKit

final class AppCoordinator: ParentCoordinator {
  var services: ServicesProtocol

  var children: [Coordinator] = []

  var onFinish: ((Coordinator) -> Void)?

  let window: UIWindow
  let windowHandler: WindowHandler

  var navigation: UINavigationController = .init()

  init(
    windowHandler: WindowHandler,
    services: ServicesProtocol
  ) {
    self.windowHandler = windowHandler
    self.services = services
    window = windowHandler.window!
  }

  func start() {
    window.setRootViewControllerAnimated(nil)
    setupRoot()
    window.makeKeyAndVisible()
  }

  private func setupRoot() {
    children.removeAll()
    showList()
  }

  private func sessionExpire() {
    start()
  }
}

extension AppCoordinator {
  func showList() {
    let coordinator = ListCoordinator(services: services)
    startChild(coordinator)
    window.setRootViewControllerAnimated(coordinator.navigation)
    navigation = coordinator.navigation
  }

  func didFinish(_ coordinator: Coordinator) {
    removeChild(coordinator)
    start()
  }
}
