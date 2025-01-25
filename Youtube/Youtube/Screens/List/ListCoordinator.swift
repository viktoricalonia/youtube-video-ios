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
    vc.viewModel = YoutubeVidListViewModel(api: services.videoAPI)
    vc.onTapItem = { [weak self] video in
      self?.presentVideo(video)
    }
    navigation.pushViewController(vc, animated: true)
  }
  
  func presentVideo(_ video: Video) {
    let vc = R.storyboard.list.videoController()!
    vc.viewModel = VideoPageViewModel(video: video, api: services.commentAPI)

    vc.modalPresentationStyle = .popover
    let nc = NavigationController(rootViewController: vc)
    navigation.present(nc, animated: true)
  }
}
