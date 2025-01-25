import Foundation
import UIKit

import SVProgressHUD

final class VideoController: UITableViewController {
  var viewModel: VideoPageProtocol!
  
  lazy var progressHUDPresenter: ProgressHUDPresenter = self
  
  private lazy var dataSource: UITableViewDiffableDataSource<Section, Comment> = makeDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    
    setupTable()
    refreshData()
  }
}

extension VideoController {
  enum Section {
    case main
  }
}

extension VideoController {
  private func setupTable() {
    tableView.registerCells(nibs: [
      R.nib.commentCell
    ])
    let header = R.nib.videoHeaderView(withOwner: self)!
    header.video = viewModel.video
    tableView.tableHeaderView = header
  }
}

extension VideoController {
  func makeDataSource() -> UITableViewDiffableDataSource<Section, Comment> {
    let dataSource = UITableViewDiffableDataSource<Section, Comment>(
      tableView: tableView,
      cellProvider: { tableView, indexPath, cellViewModel in
        let cell = tableView.dequeueReusableCell(
          withIdentifier: R.nib.commentCell.name,
          for: indexPath)
        if let cell = cell as? CommentCell {
          cell.comment = cellViewModel
        }
        return cell
    })
    dataSource.defaultRowAnimation = .fade
    return dataSource
  }
}

extension VideoController {
  @objc
  func refreshData() {
    refreshControl?.beginRefreshing()
    Task { @MainActor [weak self] in
      do {
        let comments = try await self?.viewModel.getComments()
        
        self?.reloadTable(with: comments ?? [])
        self?.refreshControl?.endRefreshing()
      } catch {
        self?.progressHUDPresenter.showDismissableError(with: error.localizedDescription)
      }
    }
  }
  
  func reloadTable(with comments: [Comment]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Comment>()
    snapshot.appendSections([.main])
    snapshot.appendItems(comments)
    
    dataSource.apply(snapshot)
  }
}
