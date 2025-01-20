import Foundation
import UIKit

class ListCoordinator: NavigationCoordinator {
  override func start() {
    pushListController()
  }
}

extension ListCoordinator {
  func pushListController() {
    let vc = R.storyboard.list.listTableController()!
    navigation.pushViewController(vc, animated: true)
  }
}
