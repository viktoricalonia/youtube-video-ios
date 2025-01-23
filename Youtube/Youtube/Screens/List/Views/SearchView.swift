import Foundation
import UIKit

final class SearchView: UIView {
  var onSearch: ((String) -> Void)?
  
  @IBOutlet var searchBarView: UISearchBar!
}

extension SearchView: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    onSearch?(searchBar.text ?? "")
  }
}
