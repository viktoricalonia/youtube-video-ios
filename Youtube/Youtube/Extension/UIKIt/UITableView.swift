import Foundation
import UIKit

import RswiftResources

extension UITableView {
  func registerCells(nibs: [any NibReferenceContainer]) {
    nibs.forEach({ register(UINib(resource: $0), forCellReuseIdentifier: $0.name) })
  }

  func registerHeaderFooter(nibs: [any NibReferenceContainer]) {
    nibs.forEach({
      register(
        UINib(resource: $0),
        forHeaderFooterViewReuseIdentifier: $0.name)
    })
  }
}
