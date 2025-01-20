import Foundation

protocol ParentCoordinator: Coordinator, CoordinatorDelegate {
  var services: ServicesProtocol { get } // This one will hold all services of our app
  var children: [Coordinator] { get set }
}

extension ParentCoordinator {
  func startChild(_ coordinator: Coordinator) {
    addChild(coordinator)
    coordinator.start()
    coordinator.onFinish = { [weak self] c in self?.didFinish(c) }
  }

  func addChild(_ child: Coordinator) {
    children.append(child)
  }

  func removeChild(_ child: Coordinator) {
    children.removeAll { $0 === child }
  }

  func didFinish(_ coordinator: Coordinator) {
    removeChild(coordinator)
  }
}
