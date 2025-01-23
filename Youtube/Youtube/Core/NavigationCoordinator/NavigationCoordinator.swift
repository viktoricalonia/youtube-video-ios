import Foundation
import UIKit

open class NavigationCoordinator: NSObject, ParentCoordinator {
  var onFinish: ((Coordinator) -> Void)?

  private(set) var navigation: UINavigationController

  let services: ServicesProtocol
  var children: [Coordinator] = []

  init(
    services: ServicesProtocol,
    navigation: UINavigationController = NavigationController()
  ) {
    self.services = services
    self.navigation = navigation

    super.init()
  }

  open func start() {}
}
