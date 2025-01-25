
import Foundation
import UIKit

import RswiftResources

final class ListTableController: UITableViewController {
  var onTapItem: ((Video) -> Void)?

  var viewModel: ListViewModel!
  lazy var hudPresenter: ProgressHUDPresenter = self
  
  private lazy var dataSource: UITableViewDiffableDataSource<Section, Video> = makeDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()

    registerCells()
    addRefreshControl()
    refreshData()
  }
}

private extension ListTableController {
  enum Section: Int {
    case main
  }
}

private extension ListTableController {
  func makeDataSource() -> UITableViewDiffableDataSource<Section, Video>{
    let dataSource = UITableViewDiffableDataSource<Section, Video>(
      tableView: tableView,
      cellProvider: { tableView, indexPath, cellViewModel in
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.listCell.name, for: indexPath)
        if let cell = cell as? ListCell {
          cell.viewModel = cellViewModel
        }
        return cell
    })
    dataSource.defaultRowAnimation = .fade
    return dataSource
  }
}

private extension ListTableController {
  func registerCells() {
    tableView.registerCells(nibs: [
      R.nib.listCell
    ])
    tableView.dataSource = dataSource
    tableView.delegate = self
    
    let searchBar: SearchView = R.nib.searchView(withOwner: self)!
    searchBar.onSearch = { [weak self] query in
      if !query.isEmpty {
        self?.searchQuery(query)
      }
    }
    tableView.tableHeaderView = searchBar
  }
  
  func addRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    self.refreshControl = refreshControl
    
    tableView.refreshControl = refreshControl
  }

  func reloadItems(_ items: [Video] = []) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Video>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items)
    
    dataSource.apply(snapshot)
  }
}

private extension ListTableController {
  func searchQuery(_ query: String = "") {
    guard query.isEmpty == false else {
      return
    }
    
    self.refreshControl?.beginRefreshing()
    Task { [weak self] in
      do {
        let items = try await self?.viewModel.searchItems(query: query)

        Task { @MainActor in
          self?.reloadItems(items ?? [])
          self?.refreshControl?.endRefreshing()
        }
      } catch {
        Task { @MainActor in
          self?.hudPresenter.showDismissableError(with: error.localizedDescription)
        }
      }
    }
  }
  
  @objc
  func refreshData() {
    self.refreshControl?.beginRefreshing()
    Task { @MainActor [weak self] in
      do {
        let items = try await self?.viewModel.fetchItems()
        
        self?.reloadItems(items ?? [])
        self?.refreshControl?.endRefreshing()
      } catch {
        self?.hudPresenter.showDismissableError(with: error.localizedDescription)
      }
    }
  }
}

extension ListTableController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    onTapItem?(
      dataSource.snapshot().itemIdentifiers[indexPath.row]
    )
  }
}

extension ListTableController {
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -10 {
      scrollView.endEditing(true)
    }
  }
}
