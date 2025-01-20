import Foundation
import UIKit

class ListCoordinator: NavigationCoordinator {
  override func start() {
    pushListController()
  }
}

extension ListCoordinator {
  func pushListController() {
    navigation.pushViewController(UIViewController(), animated: true)
  }
}
