
import Foundation
import UIKit

import RswiftResources

class ListTableController: UITableViewController {

  var viewModel: ListViewModel!
  var hudPresenter: ProgressHUDPresenter!

  override func viewDidLoad() {
    super.viewDidLoad()

    registerCells()
  }
}

private extension ListTableController {
  func registerCells() {
    tableView.registerCells(nibs: [
      R.nib.listCell
    ])
  }

  func addRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    self.refreshControl = refreshControl
  }

  @objc
  func refreshData() {
    Task { [weak self] in
      do {
        self?.refreshControl?.beginRefreshing()
        try await self?.viewModel.fetchItems()
        
        self?.tableView.reloadData()
        self?.refreshControl?.endRefreshing()
      } catch {
        self?.showDismissableError(with: error.localizedDescription)
      }
    }
  }
}
