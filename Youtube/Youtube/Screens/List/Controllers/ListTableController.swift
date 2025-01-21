
import Foundation
import UIKit

import SVProgressHUD

class ListTableController: UITableViewController {

  var viewModel: ListViewModel!

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

  func refreshData() {
    do {
      self.refreshControl?.beginRefreshing()
      try async viewModel.fetchItems()
    } catch {


    }
  }
}
