import Foundation
import UIKit

open class NavigationCoordinator: NSObject, ParentCoordinator {
  var onFinish: SingleResult<Coordinator>?

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

    navigation.delegate = self
  }

  open func start() {}
}

extension NavigationCoordinator: UINavigationControllerDelegate {
  public func navigationController(
    _: UINavigationController,
    didShow _: UIViewController,
    animated _: Bool
  ) {
    // let screenName = viewController.analyticsScreenCaptureName
    // services.survey.visitedScreen(name: screenName)
    // captureScreen(name: screenName)
  }
}
